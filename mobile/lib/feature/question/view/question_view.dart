import 'package:anka/product/services/image_choose_file.dart';
import 'package:anka/product/services/question_upload.dart';
import 'package:anka/product/widgets/appbar/appbar.dart';
import 'package:anka/product/widgets/button/button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class QuestionView extends StatefulWidget {
  const QuestionView({super.key});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  bool _isLoading = false;
  String? _questionResult;

  @override
  void initState() {
    super.initState();
    // Sayfa oluşturulduğunda ChooseFile sınıfındaki objFile değişkenini sıfırla
    ChooseFile.objFile = null;
  }

  Future<void> _uploadFile(BuildContext context) async {
    if (ChooseFile.objFile?.size != null) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      final result = await QuestionUploadService.uploadSelectedFile(
        context,
        ChooseFile.objFile?.bytes,
        ChooseFile.objFile!.name,
      );

      setState(() {
        _isLoading = false; // Hide loading indicator
        _questionResult = result; // Store the result to display
      });
    } else {
      BotToast.showText(
        text: 'Lütfen Önce Dosya Seçiniz!',
        contentColor: Theme.of(context).colorScheme.error,
      );
    }
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
                        'Soru Çözdür',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                              width: 2.0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CustomButton(
                              onPressed: () async {
                                await ChooseFile.chooseFileUsingFilePicker();
                                setState(() {});
                              },
                              text: 'Dosya Seç',
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'Dosya Adı: ${ChooseFile.objFile?.name ?? 'Dosya Seçilmedi'}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inverseSurface,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                'Dosya Boyutu: ${((ChooseFile.objFile?.size.toDouble() ?? 0) / 1000000).toStringAsFixed(2)} Mb',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inverseSurface,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CustomButton(
                        onPressed: () {
                          if (!_isLoading) {
                            _uploadFile(context);
                          }
                        },
                        text: 'Gönder',
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_questionResult != null)
                      Column(
                        children: [
                          Image.memory(
                            ChooseFile.objFile!.bytes!,
                            width: MediaQuery.of(context).size.width * 0.8,
                            fit: BoxFit.fitWidth,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.5,
                            margin: const EdgeInsets.all(16.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.end,
                                    children: [
                                      Wrap(
                                        children: [
                                          IconButton(
                                            icon:
                                                const Icon(Icons.copy_outlined),
                                            onPressed: () async {
                                              await FlutterClipboard.copy(
                                                  _questionResult!);
                                              BotToast.showText(
                                                  text:
                                                      'Soru Yanıtı Kopyalandı',
                                                  contentColor: Colors.green);
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                                Icons.ios_share_outlined),
                                            onPressed: () async {
                                              await Share.share(
                                                _questionResult!,
                                                subject:
                                                    'Bu Özet ANKA Tarafından Oluşturulmuştur',
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Html(
                                      data: '$_questionResult',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
