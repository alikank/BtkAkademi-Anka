import os
from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth import logout, authenticate, login
from django.contrib.auth.decorators import login_required
from rest_framework import generics, status
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.tokens import RefreshToken
from .forms import LoginForm
from .models import Questions, Students, MermaidHistory
from .serializers import StudentSerializer, LoginSerializer
import requests
from django.shortcuts import render
from django.conf import settings
import re
from rest_framework.decorators import api_view
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication
from django.core.files.storage import default_storage
from django.http import JsonResponse
from rest_framework.decorators import (
    api_view,
    permission_classes,
    authentication_classes,
)
import json
from django.core.exceptions import ValidationError
from django.views.decorators.http import require_POST
from django.contrib.auth.decorators import login_required
import jwt
import google.generativeai as genai
from rest_framework.authentication import TokenAuthentication
from PIL import Image
import io
import google.ai.generativelanguage as glm
from PyPDF2 import PdfReader
from dashboard.utils import (
    generate_mermaid_code,
    generate_gemini_solution,
    extract_text_from_pdf,
    summarize_text,
)


def login_page(request):
    if request.user.is_authenticated:
        return redirect("homepage_view")

    form = LoginForm(request.POST or None)
    if request.method == "POST" and form.is_valid():
        email = form.cleaned_data.get("email")
        password = form.cleaned_data.get("password")
        user = authenticate(request, username=email, password=password)
        if user:
            login(request, user)
            return redirect("homepage_view")
        else:
            form.add_error(None, "Email veya şifre yanlış.")
    return render(request, "login.html", {"form": form})


@login_required(login_url="login_page")
def logout_page(request):
    logout(request)
    return redirect("login_page")


@login_required(login_url="login_page")
def homepage_view(request):
    student = get_object_or_404(Students, user=request.user)
    return render(request, "homepage.html", {"student": student})


@login_required(login_url="login_page")
def profile(request):
    student = get_object_or_404(Students, user=request.user)
    return render(request, "user_profile.html", {"student": student})


@login_required(login_url="login_page")
def note_page(request):
    return render(request, "note.html")


@login_required
@require_POST
def call_gemini_web(request):
    prompt_text = request.POST.get("prompt")
    if not prompt_text:
        return JsonResponse({"error": "Lütfen bir başlık veya kod girin."}, status=400)

    response = generate_mermaid_code(prompt_text)

    if isinstance(response, JsonResponse):
        return response

    return JsonResponse({"mermaid_code": response})


@login_required
@require_POST
def save_mermaid_code(request):
    try:
        data = json.loads(request.body)
        mermaid_code = data.get("mermaid_code")
        prompt_text = data.get("prompt_text")
        if not mermaid_code:
            return JsonResponse({"error": "Mermaid kodu boş olamaz."}, status=400)

        student = get_object_or_404(Students, user=request.user)

        MermaidHistory.objects.create(
            student_id=student,
            prompt_text=prompt_text,
            generated_code=mermaid_code,
        )

        return JsonResponse({"success": "Mermaid kodu başarıyla kaydedildi."})

    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)


@login_required
def saved_diagrams(request):
    student = request.user.students
    diagrams = MermaidHistory.objects.filter(student_id=student).order_by(
        "-created_time"
    )
    return render(request, "saved_diagrams.html", {"diagrams": diagrams})


@login_required
def question(request):
    if request.method == "POST":
        image_data = request.FILES.get("foto")
        if image_data:
            try:
                file_extension = os.path.splitext(image_data.name)[-1].lower()
                if file_extension not in [".png", ".jpg", ".jpeg"]:
                    return render(
                        request,
                        "question.html",
                        {
                            "error": "Yalnızca PNG veya JPEG formatında dosyalar yüklenebilir."
                        },
                    )

                question_instance = Questions(student_id=request.user.students)
                question_instance.image = image_data
                question_instance.save()

            except Exception as e:
                return render(
                    "question.html",
                    {"error": "Geçersiz görüntü dosyası. " + e},
                )

            return_text = generate_gemini_solution(image_data)
            question_instance.gemini_response = return_text
            question_instance.save()

            return render(
                request,
                "question.html",
                {
                    "answer": return_text,
                    "uploaded_image_url": question_instance.image.url,
                },
            )
        else:
            return render(request, "question.html", {"error": "Görüntü yüklenmedi"})

    return render(request, "question.html")


@login_required
def questions(request):
    student_questions = Questions.objects.filter(
        student_id=request.user.students
    ).order_by("-created_time")
    return render(request, "questions.html", {"questions": student_questions})


@login_required
def question_detail(request, question_id):
    student_question = Questions.objects.filter(
        question_id=question_id, student_id=request.user.students
    ).first
    return render(request, "question-detail.html", {"question": student_question})


@login_required
def summarize_pdf_web(request):
    if request.method == "POST":
        pdf_file = request.FILES.get("pdf_file")
        if pdf_file:
            file_extension = os.path.splitext(pdf_file.name)[-1].lower()
            if file_extension != ".pdf":
                return render(
                    request,
                    "summarize_pdf.html",
                    {"error": "Yalnızca PDF dosyaları yüklenebilir."},
                )
            try:
                pdf_text = extract_text_from_pdf(pdf_file)
                summary_text = summarize_text(pdf_text)
                return render(request, "summarize_pdf.html", {"summary": summary_text})
            except ValidationError as e:
                return render(request, "summarize_pdf.html", {"error": str(e)})
        else:
            return render(
                request, "summarize_pdf.html", {"error": "PDF dosyası yüklenmedi."}
            )

    return render(request, "summarize_pdf.html")


@login_required(login_url="login_page")
def delete_mermaid_history(request, history_id):
    student = request.user.students
    history = get_object_or_404(
        MermaidHistory, history_id=history_id, student_id=student
    )
    history.delete()
    return redirect("saved_diagrams")


@login_required(login_url="login_page")
def delete_question(request, question_id):
    student = request.user.students
    question = get_object_or_404(Questions, question_id=question_id, student_id=student)

    if question.image:
        image_path = question.image.path
        if os.path.isfile(image_path):
            os.remove(image_path)

    question.delete()
    return redirect("questions_page")
