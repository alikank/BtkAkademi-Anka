from django.contrib import admin
from dashboard.models import Students


class StudentsAdmin(admin.ModelAdmin):
    list_display = ("student_namesurname", "student_school", "student_email")
    list_filter = ["student_school"]
    search_fields = ["student_namesurname", "student_email"]
    date_hierarchy = "student_birthday"
    readonly_fields = ["student_id"]
    list_editable = ["student_email", "student_school"]
    list_per_page = 20


admin.site.site_header = "BtkAkademi Anka Admin Panel"
admin.site.site_title = "BtkAkademi Anka Admin Panel"
admin.site.register(Students, StudentsAdmin)
