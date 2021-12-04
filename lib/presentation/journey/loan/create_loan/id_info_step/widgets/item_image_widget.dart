import 'dart:typed_data';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:p2p_borrower/common/constants/type_picture.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/bottom_sheets/bottom_sheet_default/picker_image_bottomsheet.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/circle_icon_button.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/id_info_step/cubit/id_info_step_cubit.dart';

class ItemImageWidget extends StatelessWidget {
  ItemImageWidget(
      {Key? key,
      this.errorText,
      this.imageBytes,
      required this.typePicture,
      required this.deletePictureCallback})
      : super(key: key) {
    switch (this.typePicture) {
      case TypePicture.idCardWithUserImage:
        label = S.current.cardWithUserImageLabel;
        description = S.current.cardWithUserImageHint;
        break;
      case TypePicture.idCardFrontImage:
        label = S.current.cardFrontImageLabel;
        description = S.current.cardFrontImageHint;
        break;
      case TypePicture.idCardBackImage:
        label = S.current.cardBackImageLabel;
        description = S.current.cardBackImageHint;
        break;
    }
  }

  late String label, description;

  final TypePicture typePicture;
  final Uint8List? imageBytes;
  final Function deletePictureCallback;
  final String? errorText;

  final _heightItem = 162.h;

  @override
  Widget build(BuildContext context) {
    print(errorText);
    return FormField<bool>(
      validator: (value) {
        if (errorText != null) {
          return errorText;
        }
        return null;
      },
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _labelWidget(context),
          imageBytes == null
              ? _emptyImageWidget(context)
              : _imageWidget(context),
          if (errorText != null)
            Padding(
              padding: EdgeInsets.only(
                top: 8.w,
                left: 16.w,
                right: 16.w,
              ),
              child: Text(
                errorText!,
                style: Theme.of(context).textTheme.textErrorTextField,
              ),
            )
        ],
      ),
    );
  }

  Widget _labelWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        label,
        style: Theme.of(context).textTheme.textLabelTextField,
      ),
    );
  }

  Widget _imageWidget(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
          height: _heightItem,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0.w),
            child: Container(
              decoration: errorText != null
                  ? BoxDecoration(
                      border: Border.all(color: mColorBad),
                      borderRadius: BorderRadius.circular(4.0.w),
                    )
                  : null,
              child: Image.memory(
                imageBytes!,
                height: _heightItem,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
            top: 0,
            right: 8.w,
            child: CircleIconButton(
              icon: Icons.close,
              borderColor: Colors.white,
              bgColor: Colors.black,
              iconColor: Colors.white,
              callback: imageBytes != null
                  ? () {
                      deletePictureCallback();
                    }
                  : () {},
            ))
      ],
    );
  }

  Widget _emptyImageWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => PickerImageBottomSheet.show(
          context: context,
          cameraCallback: () async {
            await BlocProvider.of<IDInfoStepCubit>(context)
                .pickerPicture(ImageSource.camera, typePicture);
          },
          galleryCallback: () async {
            await BlocProvider.of<IDInfoStepCubit>(context)
                .pickerPicture(ImageSource.gallery, typePicture);
          }),
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h),
        height: _heightItem,
        child: DottedBorder(
          color: mColorDottedBorder,
          radius: Radius.circular(4.w),
          dashPattern: [5, 3],
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Icon(
                  Icons.add,
                  size: 32.w,
                  color: mColorIconGreen,
                ),
              ),
              VerticalSpace.init32(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: mColorSubtext),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
