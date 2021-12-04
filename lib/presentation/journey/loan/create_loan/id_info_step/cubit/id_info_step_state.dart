part of 'id_info_step_cubit.dart';

abstract class IDInfoStepState extends Equatable {
  const IDInfoStepState();
}

class IDInfoStepInitial extends IDInfoStepState {
  @override
  List<Object> get props => [];
}

class IDInfoStepLoaded extends IDInfoStepState {
  Uint8List? idCardWithUserImage;
  Uint8List? idCardFrontImage;
  Uint8List? idCardBackImage;
  Map<String, ValidateAttribute>? profileValidAttribute;

  bool isCurrent;

  bool get isValid =>
      idCardWithUserImage != null &&
      idCardFrontImage != null &&
      idCardBackImage != null;

  IDInfoStepLoaded(
      {this.idCardWithUserImage,
      this.idCardFrontImage,
      this.idCardBackImage,
      this.profileValidAttribute,
      this.isCurrent = true});

  IDInfoStepLoaded copyWith(
      {required TypePicture typePicture,
      required Uint8List? file,
      Map<String, ValidateAttribute>? profileValidAttribute}) {
    switch (typePicture) {
      case TypePicture.idCardWithUserImage:
        return IDInfoStepLoaded(
            isCurrent: !isCurrent,
            idCardWithUserImage: file,
            idCardBackImage: idCardBackImage,
            profileValidAttribute:
                profileValidAttribute ?? this.profileValidAttribute,
            idCardFrontImage: idCardFrontImage);
      case TypePicture.idCardFrontImage:
        return IDInfoStepLoaded(
            isCurrent: !isCurrent,
            idCardWithUserImage: idCardWithUserImage,
            profileValidAttribute:
                profileValidAttribute ?? this.profileValidAttribute,
            idCardBackImage: idCardBackImage,
            idCardFrontImage: file);
      case TypePicture.idCardBackImage:
        return IDInfoStepLoaded(
            isCurrent: !isCurrent,
            idCardWithUserImage: idCardWithUserImage,
            profileValidAttribute:
                profileValidAttribute ?? this.profileValidAttribute,
            idCardBackImage: file,
            idCardFrontImage: idCardFrontImage);
    }
  }

  @override
  List<Object> get props => [
        if (profileValidAttribute != null) profileValidAttribute!,
        if (idCardWithUserImage != null) idCardWithUserImage!,
        if (idCardFrontImage != null) idCardFrontImage!,
        if (idCardBackImage != null) idCardBackImage!,
        isCurrent
      ];
}
