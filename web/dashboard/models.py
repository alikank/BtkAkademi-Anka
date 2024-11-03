from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver


class Students(models.Model):
    student_id = models.BigAutoField(primary_key=True, verbose_name="Öğrenci ID")
    student_namesurname = models.CharField(
        max_length=200, verbose_name="Öğrenci Ad Soyad", blank=False, null=False
    )
    student_birthday = models.DateField(verbose_name="Öğrenci Doğum Tarihi")
    student_school = models.CharField(max_length=255, verbose_name="Öğrenci Okulu")
    student_email = models.EmailField(verbose_name="Öğrenci Email", blank=False)
    password = models.CharField(
        max_length=128, verbose_name="Öğrenci Şifresi", blank=False, null=False
    )
    user = models.OneToOneField(User, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return f"{self.student_namesurname}"

    class Meta:
        verbose_name = "Öğrenci"
        verbose_name_plural = "Öğrenciler"


class MermaidHistory(models.Model):
    history_id = models.BigAutoField(primary_key=True, verbose_name="Mermaid Geçmiş ID")
    student_id = models.ForeignKey(
        Students,
        on_delete=models.CASCADE,
        related_name="mermaid_history",
        verbose_name="Öğrenci Bilgisi",
    )
    prompt_text = models.TextField(verbose_name="Mermaid Prompt")
    generated_code = models.TextField(verbose_name="Mermaid Kodu")
    created_time = models.DateField(verbose_name="Tarih", auto_now_add=True)

    def __str__(self):
        return f"{self.student_id.student_namesurname}"


class Questions(models.Model):
    question_id = models.BigAutoField(primary_key=True, verbose_name="Soru ID")
    student_id = models.ForeignKey(
        Students,
        on_delete=models.CASCADE,
        related_name="questions",
        verbose_name="Öğrenci Bilgisi",
    )
    image = models.ImageField(upload_to="questions/", verbose_name="Soru Fotoğrafı")
    gemini_response = models.TextField(verbose_name="Gemini Cevabı")
    created_time = models.DateField(verbose_name="Tarih", auto_now_add=True)

    def __str__(self):
        return f"{self.student_id.student_namesurname}"


@receiver(post_save, sender=Students)
def create_user_for_student(sender, instance, created, **kwargs):
    if created:
        mail = instance.student_email

        user = User.objects.create(username=mail, email=mail)

        new_password = instance.password
        user.set_password(new_password)
        user.save()

        instance.user = user
        instance.save()
