import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NoteUploadService {
  static String? resultNote = '';

  static Future<String?> uploadSelectedNote(
    BuildContext context,
    String note,
  ) async {
    final url = Uri.http('127.0.0.1:8000', 'api/call_gemini/');
    final request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });

    request.fields['response_format'] = 'verbose_json';
    request.fields['prompt'] = note;

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(json.decode(utf8.decode(response.bodyBytes)));
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        resultNote = responseData['mermaid_code'].toString();
        print(resultNote);
        return resultNote;
      } else {
        throw Exception(
          'API request failed with status ${response.statusCode}',
        );
      }
    } catch (e) {
      // Hata durumunda yapılacak işlemler
      BotToast.showText(text: 'Pleas check your internet connection.');
      return null;
    }
  }
}
