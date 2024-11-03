from django.conf import settings
import re
from django.http import JsonResponse
import google.generativeai as genai
import io
from PIL import Image
import google.ai.generativelanguage as glm
from django.conf import settings
import os
from PyPDF2 import PdfReader
from django.conf import settings
from django.core.exceptions import ValidationError


def generate_mermaid_code(prompt_text):
    genai.configure(api_key=settings.GEMINI_API_KEY)
    try:
        model = genai.GenerativeModel("gemini-1.5-flash")
        response = model.generate_content(
            f""" Sen sana verilen konuyu öğrencilere görsel açıdan açıklayan bir eğitimcisin.
            Verilen konuyla ilgili olan alt başlıkları, önemli noktaları ve bilinmesi gereken bir içeriğini öğrencilere aktarman gerekiyor.
            Lütfen aşağıdaki konu için en uygun mermaid diyagram kodunu oluştur.
            Aşağıdaki diyagram türlerinden verilen konuya göre öğrencinin en kolay ve en etkin öğrenebileceği şekilde seç:

            1. Akış şeması için flowchart LR
            A[Başlık] --> B[Alt Başlık];

            2. Sıralı işlemler için: sequenceDiagram
            participant A as Süreç1
            participant B as Süreç2
            A->>B: İşlem

            3. Durum makinesi için: stateDiagram-v2
            [*] --> Başlangıç
            Başlangıç --> Son

            4. Gantt şeması ve timeline için: gantt
            title Proje Planı
            section Bölüm1
            Görev1: 2024-01-01, 30d

            5. Pasta grafiği için: pie
            title Dağılım
            "A" : 50
            "B" : 50

            6. Alt Başlıklı tablolar için: flowchart LR
            subgraph
                    A[Başlık]
                    B[Başlık]
            end
            
            Kurallar:
            1. Türkçe karakter kullanma
            2. Mantıklı ve anlamlı bağlantılar kur
            3. Verilen konuyu kapsayacak şekilde diyagramı oluştur.
            4. Konuya en uygun diyagram türünü seç
            5. Ekstra açıklama veya yorum ekleme. No comments.
            6. Don't add comments with () next to the node content
            7. gerekli yerlerde end kullan
            Konu: {prompt_text}"""
        )

        mermaid_code = response.text.strip()
        mermaid_code = re.sub(r"```mermaid\n|```", "", mermaid_code).strip()

        tr_chars = str.maketrans("çğıöşüÇĞİÖŞÜ", "cgiosuCGIOSU")
        mermaid_code = mermaid_code.translate(tr_chars)

        def fix_diagram(code):
            diagram_type = None
            if code.startswith("flowchart") or code.startswith("graph"):
                diagram_type = "flowchart"
            elif code.startswith("sequenceDiagram"):
                diagram_type = "sequence"
            elif code.startswith("stateDiagram"):
                diagram_type = "state"
            elif code.startswith("classDiagram"):
                diagram_type = "class"
            elif code.startswith("gantt"):
                diagram_type = "gantt"
            elif code.startswith("pie"):
                diagram_type = "pie"

            lines = code.split("\n")
            fixed_lines = []

            for line in lines:
                line = line.strip()
                if not line:
                    continue

                line = re.sub(r"\(([^)]*)\)", r" \1 ", line)

                if diagram_type == "flowchart":
                    line = re.sub(r"\s*-+>\s*", " --> ", line)
                    line = re.sub(r"([A-Z])\s*\[", r"\1[", line)
                    if not line.endswith(";"):
                        line += ";"
                elif diagram_type == "sequence":
                    if line.startswith("participant"):
                        line = re.sub(
                            r"participant\s+([A-Za-z0-9]+)\s+as\s+",
                            r"participant \1 as ",
                            line,
                        )
                elif diagram_type == "state":
                    line = re.sub(r"\s*-->\s*", " --> ", line)
                elif diagram_type == "gantt":
                    line = re.sub(r"(\d{4}-\d{2}-\d{2})", r"\1", line)
                elif diagram_type == "graph LR":
                    if not (mermaid_code.endswith("end")):
                        mermaid_code += "\n end"
                fixed_lines.append(line)

            return "\n".join(fixed_lines)

        mermaid_code = fix_diagram(mermaid_code)

        valid_starts = [
            "flowchart",
            "sequenceDiagram",
            "stateDiagram",
            "classDiagram",
            "gantt",
            "pie",
            "graph LR",
        ]
        print(mermaid_code)
        if not any(mermaid_code.startswith(start) for start in valid_starts):
            return JsonResponse(
                {"error": "Geçersiz diyagram yapısı oluşturuldu."}, status=400
            )

        return mermaid_code

    except genai.AuthenticationError:
        return JsonResponse({"error": "API anahtarı doğrulanamadı."}, status=401)
    except genai.APIError as api_error:
        return JsonResponse({"error": f"API hatası: {str(api_error)}"}, status=500)
    except Exception as e:
        return JsonResponse({"error": f"Beklenmeyen bir hata: {str(e)}"}, status=500)


def generate_gemini_solution(image_data):
    genai.configure(api_key=settings.GEMINI_API_KEY)

    image = Image.open(image_data)
    if image.mode == "RGBA":
        background = Image.new("RGB", image.size, (255, 255, 255))
        background.paste(image, mask=image.split()[3])
        image = background
    elif image.mode != "RGB":
        image = image.convert("RGB")

    image_bytes = io.BytesIO()
    image.save(image_bytes, format="JPEG")
    image_data = image_bytes.getvalue()
    image_end = glm.Blob(mime_type="image/jpeg", data=image_data)

    model = genai.GenerativeModel(model_name="gemini-1.5-pro")
    answer = model.generate_content(
        [
            image_end,
            "Soruyu detaylı anlatarak çöz, tüm detayları aktar. Sadece text şeklinde dönüş yap ve paragraflar arasını ayırmak için \n ekle.",
        ]
    )
    return answer.text.replace("\n", "<br>").strip()


def extract_text_from_pdf(pdf_file):
    try:
        pdf_reader = PdfReader(pdf_file)
        pdf_text = ""
        for page in pdf_reader.pages:
            pdf_text += page.extract_text() + "\n"
        if not pdf_text.strip():
            raise ValidationError("PDF'den metin çıkarılamadı.")
        return pdf_text
    except Exception as e:
        raise ValidationError(f"Geçersiz PDF dosyası. {e}")


def summarize_text(text):
    try:
        genai.configure(api_key=settings.GEMINI_API_KEY)
        model = genai.GenerativeModel(model_name="gemini-1.5-pro")
        answer = model.generate_content(
            [
                text,
                "Lütfen metni kapsamlı bir şekilde özetle. Özetin, metnin ana fikirlerini, önemli noktalarını ve çıkarılması gereken bilgileri vurgulamalıdır. Her bir ana fikri ve önemli noktayı belirgin hale getirmek için <b>etiketleri</b> kullan ve paragraflar arasını ayırmak için \n ekle. Ayrıca, metinde kullanılan özel terimlerin açıklamalarını da eklemeyi unutma.",
            ]
        )
        summary_text = answer.text.strip().replace("\n", "<br>")
        return summary_text
    except Exception as e:
        raise ValidationError(f"Özetleme başarısız oldu. {e}")
