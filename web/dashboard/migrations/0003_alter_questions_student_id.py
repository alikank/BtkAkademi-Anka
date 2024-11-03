# Generated by Django 5.1.2 on 2024-10-31 16:43

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dashboard', '0002_questions'),
    ]

    operations = [
        migrations.AlterField(
            model_name='questions',
            name='student_id',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='questions', to='dashboard.students', verbose_name='Öğrenci Bilgisi'),
        ),
    ]