import 'package:anka/product/services/pdf_choose_file.dart';
import 'package:anka/product/services/pdf_upload.dart';
import 'package:anka/product/widgets/appbar/appbar.dart';
import 'package:anka/product/widgets/button/button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share_plus/share_plus.dart';

@RoutePage()
class PdfView extends StatefulWidget {
  const PdfView({super.key});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  bool _isLoading = false;
  String? _summaryResult;

  @override
  void initState() {
    super.initState();
    PdfChooseFile.objFile = null; // Reset the selected file on page creation
  }

  Future<void> _uploadFile(BuildContext context) async {
    if (PdfChooseFile.objFile?.size != null) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      final result = await PdfUploadService.uploadSelectedFile(
        context,
        PdfChooseFile.objFile?.bytes,
        PdfChooseFile.objFile!.name,
      );

      setState(() {
        _isLoading = false; // Hide loading indicator
        _summaryResult = result; // Store the result to display
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
                        'PDF Özetle',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CustomButton(
                              onPressed: () async {
                                await PdfChooseFile.chooseFileUsingFilePicker();
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
                                  'Dosya Adı: ${PdfChooseFile.objFile?.name ?? 'Dosya Seçilmedi'}',
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
                                'Dosya Boyutu: ${((PdfChooseFile.objFile?.size.toDouble() ?? 0) / 1000000).toStringAsFixed(2)} Mb',
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
                    if (_summaryResult != null)
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
                                        icon: const Icon(Icons.copy_outlined),
                                        onPressed: () async {
                                          await FlutterClipboard.copy(
                                              _summaryResult!);
                                          BotToast.showText(
                                              text: 'Pdf Özeti Kopyalandı',
                                              contentColor: Colors.green);
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.ios_share_outlined),
                                        onPressed: () async {
                                          await Share.share(
                                            _summaryResult!,
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
                                  data: '$_summaryResult',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Text(
                    //     'Özet: $_summaryResult',
                    //     style: Theme.of(context).textTheme.bodyLarge,
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                  ],
                ),
        ),
      ),
    );
  }
}
