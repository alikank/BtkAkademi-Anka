from rest_framework import serializers
from .models import Students, Questions, MermaidHistory


class StudentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Students
        fields = [
            "student_id",
            "student_namesurname",
            "student_birthday",
            "student_school",
            "student_email",
        ]
        read_only_fields = ["student_id"]


class LoginSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField(write_only=True)


class QuestionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Questions
        fields = [
            "question_id",
            "student_id",
            "image",
            "gemini_response",
            "created_time",
        ]


class MermaidHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = MermaidHistory
        fields = ["history_id", "prompt_text", "generated_code", "created_time"]
