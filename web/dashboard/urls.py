from django.urls import path
from rest_framework_simplejwt.views import TokenRefreshView
from . import views, api_views
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path("", views.homepage_view, name="homepage_view"),
    path("login", views.login_page, name="login_page"),
    path("logout", views.logout_page, name="logout_page"),
    path("profile", views.profile, name="profile_page"),
    path("note/", views.note_page, name="note_page"),
    path("question/", views.question, name="question_page"),
    path(
        "question/<int:question_id>", views.question_detail, name="question_detail_page"
    ),
    path("questions/", views.questions, name="questions_page"),
    path(
        "delete_question/<int:question_id>/",
        views.delete_question,
        name="delete_question",
    ),
    path(
        "delete_mermaid_history/<int:history_id>/",
        views.delete_mermaid_history,
        name="delete_mermaid_history",
    ),
    path("summarize_pdf/", views.summarize_pdf_web, name="summarize_pdf"),
    path("call_gemini/", views.call_gemini_web, name="call_gemini_web"),
    path("save-mermaid-code/", views.save_mermaid_code, name="save_mermaid_code"),
    path("notes/", views.saved_diagrams, name="saved_diagrams"),
    # api urls
    path("api/login/", api_views.api_login, name="api_login"),
    path("api/profile/", api_views.api_student_profile, name="api_profile"),
    path("api/token/refresh/", TokenRefreshView.as_view(), name="token_refresh"),
    path("api/question/", api_views.api_question, name="api_question"),
    path("api/questions/", api_views.api_questions, name="api_questions"),
    path(
        "api/questions/<int:question_id>/",
        api_views.api_question_detail,
        name="api_question_detail",
    ),
    path("api/call_gemini/", api_views.call_gemini_api, name="call_gemini_api"),
    path("api/summarize_pdf/", api_views.summarize_pdf_api, name="summarize_pdf_api"),
    path("api/save_diagram/", api_views.save_diagram_api, name="save_diagram_api"),
    path("api/list_diagrams/", api_views.list_diagrams_api, name="list_diagrams_api"),
    path(
        "api/delete-mermaid/<int:history_id>/",
        api_views.delete_mermaid_history_api,
        name="delete_mermaid_api",
    ),
    path(
        "api/delete-question/<int:question_id>/",
        api_views.delete_question_api,
        name="delete_question_api",
    ),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
