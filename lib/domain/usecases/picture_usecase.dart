import 'package:image_picker/image_picker.dart';
import 'package:p2p_borrower/common/helpers/image_picker/image_picker_helper.dart';

class PictureUseCase {
  PictureUseCase({required this.imagePickerHelper});

  final ImagePickerHelper imagePickerHelper;

  Future<XFile?> pickImgFromCamera() => imagePickerHelper.imgFromCamera();

  Future<XFile?> pickImgFromGallery() => imagePickerHelper.imgFromGallery();
}
