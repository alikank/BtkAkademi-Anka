import 'dart:convert';
import 'package:anka/product/services/note_upload.dart';
import 'package:anka/product/widgets/appbar/appbar.dart';
import 'package:anka/product/widgets/button/button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  final TextEditingController textController = TextEditingController();
  bool _isLoading = false;
  String? _noteResult = """
      graph TD;
      A-->B;
      A-->C;
      B-->D;
      C-->D;
    """; // Mermaid grafiği örneği
  String? _noteResultLast;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Android için Surface Android WebView başlatma
    _initializeController();
  }

  void _initializeController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint("Yükleniyor: $progress%");
          },
          onPageStarted: (String url) {
            debugPrint("Sayfa başlıyor: $url");
          },
          onPageFinished: (String url) {
            debugPrint("Sayfa tamamlandı: $url");
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("Hata: ${error.description}");
          },
        ),
      )
      ..loadRequest(Uri.dataFromString(
        _generateHtmlContent(_noteResult!),
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ));
  }

  Future<void> _uploadNote(BuildContext context) async {
    if (textController.text.isNotEmpty) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      final result = await NoteUploadService.uploadSelectedNote(
        context,
        textController.text,
      );

      setState(() {
        _noteResult = result; // Store the result to display
        _noteResultLast = result; // Store the result to display
      });

      _controller.loadRequest(
        Uri.dataFromString(
          _generateHtmlContent(_noteResult!),
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ),
      );

      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    } else {
      BotToast.showText(
        text: 'Lütfen Önce Dosya Seçiniz!',
        contentColor: Theme.of(context).colorScheme.error,
      );
    }
  }

  String _generateHtmlContent(String content) {
    return '''
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <script src="https://cdnjs.cloudflare.com/ajax/libs/mermaid/11.3.0/mermaid.min.js"></script>
      <script>
        mermaid.initialize({ startOnLoad: true });
      </script>
    </head>
    <body>
      <div class="mermaid">
        $content
      </div>
    </body>
    </html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(autoLeading: true),
      body: SingleChildScrollView(
        child: Center(
          child: _isLoading
              ? const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 32,
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: Text(
                        'Not Çıkar',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        style: Theme.of(context).textTheme.titleLarge,
                        controller: textController,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        cursorColor:
                            Theme.of(context).colorScheme.inverseSurface,
                        decoration: InputDecoration(
                          hintText: 'Başlık Veya Konu Girin',
                          hintStyle: Theme.of(context).textTheme.titleLarge,
                          labelText: 'Başlık Veya Konu',
                          labelStyle: Theme.of(context).textTheme.titleLarge,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                              width: 2,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        maxLines: 4,
                        maxLength: 4095,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomButton(
                        onPressed: () {
                          if (!_isLoading) {
                            _uploadNote(context);
                          }
                        },
                        text: 'Gönder',
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_noteResultLast != null)
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 300,
                        margin: const EdgeInsets.all(16.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: WebViewWidget(
                            controller: _controller,
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
