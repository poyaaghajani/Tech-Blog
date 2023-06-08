import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:tech_blog/controller/file_controller.dart';

Future pickFiles() async {
  final fileController = Get.put(FileController());

  FilePickerResult? result =
      await FilePicker.platform.pickFiles(type: FileType.image);

  fileController.file.value = result!.files[0];
}
