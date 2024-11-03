import 'dart:convert';
import 'dart:typed_data';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class QuestionUploadService {
  static String? resultQuestion = '';

  static Future<String?> uploadSelectedFile(
    BuildContext context,
    Uint8List? bytes,
    String filename,
  ) async {
    final url = Uri.http('127.0.0.1:8000', 'api/question/');
    final request = http.MultipartRequest('POST', url);
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });
    request.fields['response_format'] = 'verbose_json';

    final multipartFile = http.MultipartFile.fromBytes(
      'foto',
      bytes!,
      filename: filename,
    );
    try {
      request.files.add(multipartFile);
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(json.decode(utf8.decode(response.bodyBytes)));
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        resultQuestion = responseData['answer'].toString();
        print(resultQuestion);
        return resultQuestion;
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
