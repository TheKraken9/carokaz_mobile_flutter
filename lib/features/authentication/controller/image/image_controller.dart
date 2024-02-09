import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mada_jeune/commons/widgets/loaders/loaders.dart';

class ImageController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images = [];
  List<String> listImagePath = [];
  var selectedFileCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void selectMultipleImage() async {
    images = await _picker.pickMultiImage();
    if(images != null) {
      for(XFile file in images!) {
        listImagePath.add(file.path);
      }
    } else {
      TLoaders.errorSnackBar(title: 'Information', message: 'Veuillez selectionner une image');
    }

    selectedFileCount.value = listImagePath.length;
  }
}