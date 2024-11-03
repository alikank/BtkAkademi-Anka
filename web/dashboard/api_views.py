from django.contrib.auth import authenticate
from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.tokens import RefreshToken
from django.views.decorators.csrf import csrf_exempt
from .models import Students
from .serializers import (
    StudentSerializer,
    LoginSerializer,
    QuestionSerializer,
    MermaidHistorySerializer,
)
from django.conf import settings
import re
from rest_framework.decorators import api_view
from rest_framework.permissions import IsAuthenticated
from django.http import JsonResponse
from rest_framework.decorators import (
    api_view,
    permission_classes,
)
from dashboard.utils import generate_mermaid_code, generate_gemini_solution
from .models import Questions
import os
from .models import MermaidHistory, Students


from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from .utils import extract_text_from_pdf, summarize_text

from django.core.exceptions import ValidationError


class StudentProfileAPI(generics.RetrieveAPIView):
    queryset = Students.objects.all()
    serializer_class = StudentSerializer
    permission_classes = [IsAuthenticated]

    def get_object(self):
        return Students.objects.get(user=self.request.user)


@api_view(["POST"])
def api_login(request):
    serializer = LoginSerializer(data=request.data)
    if serializer.is_valid():
        email = serializer.validated_data["email"]
        password = serializer.validated_data["password"]
        user = authenticate(username=email, password=password)

        if user:
            refresh = RefreshToken.for_user(user)
            return Response(
                {
                    "access": str(refresh.access_token),
                    "refresh": str(refresh),
                    "user": StudentSerializer(user.students).data,
                }
            )
        return Response(
            {"detail": "gecersiz kimlik bilgileri"}, status=status.HTTP_401_UNAUTHORIZED
        )
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def api_student_profile(request):
    try:
        student = Students.objects.get(user=request.user)
        serializer = StudentSerializer(student)
        return Response(serializer.data)
    except Students.DoesNotExist:
        return Response(
            {"detail": "kullanici bulunamadi"}, status=status.HTTP_404_NOT_FOUND
        )


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def call_gemini_api(request):
    prompt_text = request.data.get("prompt")

    if not prompt_text:
        return JsonResponse({"error": "Lütfen bir başlık veya kod girin."}, status=400)
    response = generate_mermaid_code(prompt_text)

    if isinstance(response, JsonResponse):
        return response

    return JsonResponse({"mermaid_code": response})


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def api_question(request):
    image_data = request.FILES.get("foto")
    if not image_data:
        return Response(
            {"error": "Görüntü yüklenmedi"}, status=status.HTTP_400_BAD_REQUEST
        )

    file_extension = os.path.splitext(image_data.name)[-1].lower()
    if file_extension not in [".png", ".jpg", ".jpeg"]:
        return Response(
            {"error": "Yalnızca PNG veya JPEG formatında dosyalar yüklenebilir."},
            status=status.HTTP_400_BAD_REQUEST,
        )

    question_instance = Questions(student_id=request.user.students)
    question_instance.image = image_data
    question_instance.save()

    response_text = generate_gemini_solution(image_data)
    question_instance.gemini_response = response_text
    question_instance.save()

    return Response(
        {
            "answer": response_text,
            "uploaded_image_url": question_instance.image.url,
        },
        status=status.HTTP_201_CREATED,
    )


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def api_questions(request):
    student_questions = Questions.objects.filter(
        student_id=request.user.students
    ).order_by("-created_time")
    serializer = QuestionSerializer(student_questions, many=True)
    return Response(serializer.data)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def api_question_detail(request, question_id):
    try:
        student_question = Questions.objects.get(
            question_id=question_id, student_id=request.user.students
        )
        serializer = QuestionSerializer(student_question)
        return Response(serializer.data)
    except Questions.DoesNotExist:
        return Response(
            {"detail": "Soru bulunamadı."},
            status=status.HTTP_404_NOT_FOUND,
        )


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def summarize_pdf_api(request):
    pdf_file = request.FILES.get("pdf_file")
    if pdf_file:
        file_extension = os.path.splitext(pdf_file.name)[-1].lower()
        if file_extension != ".pdf":
            return Response(
                {"error": "Yalnızca PDF dosyaları yüklenebilir."},
                status=status.HTTP_400_BAD_REQUEST,
            )
        try:
            pdf_text = extract_text_from_pdf(pdf_file)
            summary_text = summarize_text(pdf_text)
            return Response({"summary": summary_text}, status=status.HTTP_200_OK)
        except ValidationError as e:
            return Response({"error": str(e)}, status=status.HTTP_400_BAD_REQUEST)
    else:
        return Response(
            {"error": "PDF dosyası yüklenmedi."},
            status=status.HTTP_400_BAD_REQUEST,
        )


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def save_diagram_api(request):
    try:
        mermaid_code = request.data.get("mermaid_code")
        prompt_text = request.data.get("prompt_text")

        if not mermaid_code:
            return JsonResponse({"error": "Mermaid kodu boş olamaz."}, status=400)

        student = request.user.students

        MermaidHistory.objects.create(
            student_id=student,
            prompt_text=prompt_text,
            generated_code=mermaid_code,
        )

        return JsonResponse(
            {"success": "Mermaid kodu başarıyla kaydedildi."}, status=201
        )

    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)


@api_view(["GET"])
@permission_classes([IsAuthenticated])
def list_diagrams_api(request):
    student = request.user.students
    diagrams = MermaidHistory.objects.filter(student_id=student).order_by(
        "-created_time"
    )
    serializer = MermaidHistorySerializer(diagrams, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)


@api_view(["DELETE"])
@permission_classes([IsAuthenticated])
def delete_mermaid_history_api(request, history_id):
    student = request.user.students
    history = MermaidHistory.objects.filter(
        history_id=history_id, student_id=student
    ).first()
    if history:
        history.delete()
        return Response(
            {"detail": "Mermaid geçmişi silindi"}, status=status.HTTP_200_OK
        )
    return Response(
        {"detail": "Mermaid geçmişi bulunamadı"}, status=status.HTTP_404_NOT_FOUND
    )


@api_view(["DELETE"])
@permission_classes([IsAuthenticated])
def delete_question_api(request, question_id):
    student = request.user.students
    question = Questions.objects.filter(
        question_id=question_id, student_id=student
    ).first()
    if question:
        question.delete()
        if question.image:
            image_path = question.image.path
            if os.path.isfile(image_path):
                os.remove(image_path)
        return Response({"detail": "Soru silindi"}, status=status.HTTP_200_OK)
    return Response({"detail": "Soru bulunamadı"}, status=status.HTTP_404_NOT_FOUND)
