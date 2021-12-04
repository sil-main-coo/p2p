import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_configuration_module/utility/extentions/string_extension.dart';
import 'package:p2p_borrower/common/constants/type_format_field_enum.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/additional_info_loan_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/validate_attribute_loan.dart';
import 'package:p2p_borrower/data/model/response/loan_products_response.dart';
import 'package:p2p_borrower/domain/usecases/picture_usecase.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/cubits/create_loan_cubit/create_loan_cubit.dart';

part 'addition_info_step_state.dart';

class AdditionInfoStepCubit extends Cubit<AdditionInfoStepState> {
  AdditionInfoStepCubit({required this.pictureUseCase})
      : super(AdditionInfoStepInitial());

  final PictureUseCase pictureUseCase;

  Map<int, String?> _mapTextValues = {};
  Map<int, List<Uint8List?>> _mapPictureValues = {};

  bool hasTextFormat = false;

  List<AdditionalInfoLoanDetailResponse> _additionalInfoList = [];
  List<ValidateAttribute>? _additionalValidAttribute;

  late CreateLoanCubit _createLoanCubit;

  void initData(
      CreateLoanCubit createLoanCubit,
      List<AdditionalInfoLoanDetailResponse>? additionalInfoList,
      List<AdditionalInfos> list,
      {List<ValidateAttribute>? additionalValidAttribute}) {
    _createLoanCubit = createLoanCubit;

    if (additionalValidAttribute != null) {
      _additionalValidAttribute = additionalValidAttribute;
    }

    list.forEach((element) {
      if (element.infoFormatEnum == TypeFormatFieldEnum.Text) {
        // check addition info list has text format ?
        // -> to valid map text
        hasTextFormat = true;
        _mapTextValues[element.id!] = null;
      } else if (element.infoFormatEnum == TypeFormatFieldEnum.Media) {
        _mapPictureValues[element.id!] = [];
      }
    });

    // if has not cache value -> init data
    if (additionalInfoList != null) {
      additionalInfoList.forEach((element) {
        if (element.infoFormatEnum == TypeFormatFieldEnum.Text) {
          // check addition info list has text format ?
          // -> to valid map text
          hasTextFormat = true;
          _mapTextValues[element.loanProductAdditionalInfoId!] = element.value;
        } else if (element.infoFormatEnum == TypeFormatFieldEnum.Media) {
          if (_mapPictureValues[element.loanProductAdditionalInfoId!] == null) {
            _mapPictureValues[element.loanProductAdditionalInfoId!] = [];
          }

          if (element.binaryValue != null && element.binaryValue!.isNotEmpty) {
            _mapPictureValues[element.loanProductAdditionalInfoId!]!
                .add(base64Decode(element.binaryValue!));
          }
        }
      });
    }

    emit(AdditionInfoStepLoaded(
        isValid: _isValid(),
        additionalValidAttribute: _additionalValidAttribute,
        mapPictureValues: _mapPictureValues,
        mapTextValues: _mapTextValues));
  }

  Future saveData() async {
    _additionalInfoList.clear();

    if (hasTextFormat && _mapTextValues.isNotEmpty) {
      _mapTextValues.forEach((id, value) {
        _additionalInfoList.add(AdditionalInfoLoanDetailResponse(
            value: value,
            loanProductAdditionalInfoId: id,
            infoFormat: TypeFormatFieldEnum.Text.toString().enumToName));
      });
    }

    if (_mapPictureValues.isNotEmpty) {
      _mapPictureValues.forEach((id, value) {
        value.forEach((picture) {
          String? base64;
          if (picture != null) {
            base64 = base64Encode(picture);
          }
          _additionalInfoList.add(AdditionalInfoLoanDetailResponse(
              value: base64,
              loanProductAdditionalInfoId: id,
              infoFormat: TypeFormatFieldEnum.Media.toString().enumToName));
        });
      });
    }

    // set create loan request model value in create loan cubit
    await _createLoanCubit.setAdditionalData(_additionalInfoList);
  }

  void textValueChanged(AdditionalInfos addition, String? value) {
    final currentState = state;
    if (currentState is AdditionInfoStepLoaded) {
      _mapTextValues[addition.id!] = value?.toAllDigit;
      emit(currentState.copyWith(
          isValid: _isValid(), mapTextValues: _mapTextValues));
    }
  }

  Future pickerPicture(AdditionalInfos addition, ImageSource typePick) async {
    final currentState = state;
    if (currentState is AdditionInfoStepLoaded) {
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
        _mapPictureValues[addition.id!]!
            .add(File(picture.path).readAsBytesSync());
        emit(currentState.copyWith(
            isValid: _isValid(), mapPictureValues: _mapPictureValues));
      }
    }
  }

  void deletePicture(AdditionalInfos addition, int index) {
    final currentState = state;
    if (currentState is AdditionInfoStepLoaded) {
        _mapPictureValues[addition.id!]?.removeAt(index);
         emit(currentState.copyWith(
          isValid: _isValid(), mapPictureValues: _mapPictureValues));
    }
  }

  bool _isValid() {
    return _mapPictureIsValid() && _mapTextIsValid();
  }

  bool _mapTextIsValid() {
    if (!hasTextFormat) return true;
    if (_mapTextValues.isEmpty) return false;

    for (String? text in _mapTextValues.values) {
      if (text == null || text.isEmpty) return false;
    }

    return true;
  }

  bool _mapPictureIsValid() {
    if (_mapPictureValues.isEmpty || _mapPictureValues.values.isEmpty)
      return false;
    for (List<Uint8List?>? pictures in _mapPictureValues.values) {
      if (pictures == null || pictures.isEmpty) return false;
      for (Uint8List? picture in pictures) {
        if (picture == null || picture.isEmpty) return false;
      }
    }
    return true;
  }
}
