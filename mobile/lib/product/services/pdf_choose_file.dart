import 'package:file_picker/file_picker.dart' as picker;

class PdfChooseFile {
  static picker.PlatformFile? objFile;
  static String? error;

  static Future<void> chooseFileUsingFilePicker() async {
    final result = await picker.FilePicker.platform.pickFiles(
      type: picker.FileType.custom,
      allowedExtensions: [
        'pdf',
      ],
      withData: true,
    );
    if (result != null) {
      objFile = result.files.single;
    } else {
      error = 'hata';
    }
  }
}
