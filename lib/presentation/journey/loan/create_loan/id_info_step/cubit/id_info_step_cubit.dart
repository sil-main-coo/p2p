import 'dart:convert';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p2p_borrower/common/constants/type_picture.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/validate_attribute_loan.dart';
import 'package:p2p_borrower/domain/usecases/picture_usecase.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/cubits/create_loan_cubit/create_loan_cubit.dart';

import '../../step_create_loan_constants.dart';

part 'id_info_step_state.dart';

class IDInfoStepCubit extends Cubit<IDInfoStepState> {
  IDInfoStepCubit({required this.pictureUseCase}) : super(IDInfoStepInitial());

  final PictureUseCase pictureUseCase;

  late CreateLoanCubit _createLoanCubit;

  Uint8List? _idCardFrontImage;
  Uint8List? _idCardBackImage;
  Uint8List? _idCardWithUserImage;
  Map<String, ValidateAttribute>? _profileValidAttribute;

  void initData(CreateLoanCubit createLoanCubit, String? idCardWithUserImage,
      String? idCardFrontImage, String? idCardBackImage,
      {Map<String, ValidateAttribute>? profileValidAttribute}) {
    _createLoanCubit = createLoanCubit;

    if (idCardWithUserImage != null) {
      _idCardWithUserImage = base64Decode(idCardWithUserImage);
    }
    if (idCardFrontImage != null) {
      _idCardFrontImage = base64Decode(idCardFrontImage);
    }
    if (idCardBackImage != null) {
      _idCardBackImage = base64Decode(idCardBackImage);
    }

    if (profileValidAttribute != null) {
      _profileValidAttribute = profileValidAttribute;
    }

    emit(IDInfoStepLoaded(
        profileValidAttribute: _profileValidAttribute,
        idCardBackImage: _idCardBackImage,
        idCardFrontImage: _idCardFrontImage,
        idCardWithUserImage: _idCardWithUserImage));
  }

  Future saveData() => _createLoanCubit.setIDImagesData(
      base64Encode(_idCardFrontImage!),
      base64Encode(_idCardBackImage!),
      base64Encode(_idCardWithUserImage!));

  Future pickerPicture(ImageSource typePick, TypePicture typePicture) async {
    final currentState = state;
    if (currentState is IDInfoStepLoaded) {
      XFile? picture;
      switch (typePick) {
        case ImageSource.camera:
          picture = await pictureUseCase.pickImgFromCamera();
          break;
        case ImageSource.gallery:
          picture = await pictureUseCase.pickImgFromGallery();
          break;
      }

      if (picture != null) {
        final bytes = await picture.readAsBytes();

        switch (typePicture) {
          case TypePicture.idCardWithUserImage:
            _idCardWithUserImage = bytes;
            _profileValidAttribute?[StepCreateLoanConstants.IdCardWithUserName]
                ?.setValidValue();
            break;
          case TypePicture.idCardFrontImage:
            _idCardFrontImage = bytes;
            _profileValidAttribute?[StepCreateLoanConstants.IdCardFrontName]
                ?.setValidValue();
            break;
          case TypePicture.idCardBackImage:
            _idCardBackImage = bytes;
            _profileValidAttribute?[StepCreateLoanConstants.IdCardBackName]
                ?.setValidValue();
            break;
        }
        emit(currentState.copyWith(
            file: bytes,
            typePicture: typePicture,
            profileValidAttribute: _profileValidAttribute));
      }
    }
  }

  void deletePicture(TypePicture typePicture) {
    final currentState = state;

    if (currentState is IDInfoStepLoaded) {
      switch (typePicture) {
        case TypePicture.idCardWithUserImage:
          _idCardWithUserImage = null;
          break;
        case TypePicture.idCardFrontImage:
          _idCardFrontImage = null;
          break;
        case TypePicture.idCardBackImage:
          _idCardBackImage = null;
          break;
      }

      emit(currentState.copyWith(typePicture: typePicture, file: null));
    }
  }
}
