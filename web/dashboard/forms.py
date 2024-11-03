from django import forms


class LoginForm(forms.Form):
    email = forms.EmailField(
        widget=forms.EmailInput(
            attrs={
                "class": "form-control",
                "id": "inputEmailAddress",
                "placeholder": "ogrenci@example.com",
                "value" : "demo@demo.com"
            }
        )
    )
    password = forms.CharField(
        widget=forms.PasswordInput(
            attrs={
                "class": "form-control border-end-0",
                "id": "inputChoosePassword",
                "placeholder": "Şifre",
                "value" : "demo"
            }
        )
    )
