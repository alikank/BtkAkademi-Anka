import 'package:file_picker/file_picker.dart' as picker;

class ChooseFile {
  static picker.PlatformFile? objFile;
  static String? error;

  static Future<void> chooseFileUsingFilePicker() async {
    final result = await picker.FilePicker.platform.pickFiles(
      type: picker.FileType.image,
      withData: true,
    );
    if (result != null) {
      objFile = result.files.single;
    } else {
      error = 'hata';
    }
  }
}
