import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

class SvgUseCase {
  Future<Uint8List?> pressPickSVG() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['svg'],
      withData: true
    );
    var bytes = result?.files.single.bytes;
    return bytes;
  }
}