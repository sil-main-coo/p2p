import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p2p_borrower/common/constants/type_format_field_enum.dart';
import 'package:p2p_borrower/common/utils/app_validators.dart';
import 'package:p2p_borrower/data/model/response/loan_products_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/bottom_sheets/bottom_sheet_default/picker_image_bottomsheet.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/circle_icon_button.dart';
import 'package:p2p_borrower/presentation/common/components/layout/compact_layout.dart';
import 'package:p2p_borrower/common/extensions/app_num_extension.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_textfield.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/addition_info_step/cubit/addition_info_step_cubit.dart';

import '../addition_info_step_consts.dart';

class AdditionalInfoFormWidget extends StatelessWidget {
  AdditionalInfoFormWidget(
      {Key? key,
      required this.additionalInfoList,
      required this.mapPictureValues,
      required this.mapTextValues})
      : super(key: key);

  final List<AdditionalInfos> additionalInfoList;
  final Map<int, List<Uint8List?>> mapPictureValues;
  final Map<int, String?> mapTextValues;

  final _sizeImageItem = 102.w;

  @override
  Widget build(BuildContext context) {
    final widgets = List.generate(additionalInfoList.length, (index) {
      final itemData = additionalInfoList[index];
      switch (itemData.infoFormatEnum) {
        case TypeFormatFieldEnum.Text:
          return _moneyField(context, itemData, itemData.infoName!,
              mapTextValues[itemData.id]);
        case TypeFormatFieldEnum.Media:
          return _pickerImageBoxes(context, itemData.infoName!,
              mapPictureValues[itemData.id], itemData);
        default:
          return SizedBox();
      }
    });

    return CompactLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }

  Widget _moneyField(BuildContext context, AdditionalInfos itemData,
      String label, String? initValue) {
    return Column(
      children: [
        AppTextField.money(
          initialValue: initValue != null && initValue.isNotEmpty
              ? int.parse(initValue).toDefaultFormatNumberString
              : null,
          maxLen: 50,
          validator: (value) {
            if (AppValidators.isEmptyStringData(value)) {
              return S.current.MSG31;
            }
            return null;
          },
          onChanged: (value) {
            BlocProvider.of<AdditionInfoStepCubit>(context)
                .textValueChanged(itemData, value);
          },
          labelText: label,
          isRequired: true,
          suffixIcon: Text(
            S.current.money_currency,
            style: Theme.of(context).textTheme.textContentTextField,
          ),
          hintText: '$label ${S.current.yourself.toLowerCase()}',
        ),
        VerticalSpace(height: 24)
      ],
    );
  }

  Widget _labelWidget(BuildContext context, String label) {
    return Text(
      label,
      style: Theme.of(context).textTheme.textLabelTextField,
    );
  }

  Widget _pickerImageBoxes(BuildContext context, String label,
      List<Uint8List?>? listPictureInit, AdditionalInfos itemData) {
    List<Widget> widgets = [];
    if (listPictureInit == null) {
      widgets.add(_pickerImageItemEmpty(context, itemData));
    } else {
      for (int i = 0; i < listPictureInit.length; i++) {
        final picture = listPictureInit[i];
        if (picture != null) {
          widgets.add(_imageWidget(context, itemData, picture, i));
          widgets.add(HorizontalSpace.init4());
        }
      }

      if (widgets.length < AdditionInfoStepConstants.maxPictureLen * 2)
        widgets.add(_pickerImageItemEmpty(context, itemData));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelWidget(context,
            '${S.current.picture} ${label.toLowerCase()} ${S.current.yourself.toLowerCase()}'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: widgets,
          ),
        ),
        VerticalSpace(height: 24)
      ],
    );
  }

  Widget _imageWidget(BuildContext context, AdditionalInfos itemData,
      Uint8List picture, int index) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: SizedBox(
        height: _sizeImageItem + 4.w,
        width: _sizeImageItem + 4.w,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                height: _sizeImageItem,
                width: _sizeImageItem,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0.w),
                  child: Container(
                    height: _sizeImageItem,
                    width: _sizeImageItem,
                    decoration: BoxDecoration(
                        border: Border.all(color: mColorPlaceholder),
                        borderRadius: BorderRadius.circular(4.w)),
                    child: Image.memory(
                      picture,
                      height: _sizeImageItem,
                      width: _sizeImageItem,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 0,
                right: 0,
                child: CircleIconButton(
                  icon: Icons.close,
                  borderColor: Colors.white,
                  bgColor: Colors.black,
                  iconColor: Colors.white,
                  callback: () =>
                      BlocProvider.of<AdditionInfoStepCubit>(context)
                          .deletePicture(itemData, index),
                ))
          ],
        ),
      ),
    );
  }

  Widget _pickerImageItemEmpty(BuildContext context, AdditionalInfos itemData) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: GestureDetector(
        onTap: () => PickerImageBottomSheet.show(
            context: context,
            cameraCallback: () async {
              await BlocProvider.of<AdditionInfoStepCubit>(context)
                  .pickerPicture(itemData, ImageSource.camera);
            },
            galleryCallback: () async {
              await BlocProvider.of<AdditionInfoStepCubit>(context)
                  .pickerPicture(itemData, ImageSource.gallery);
            }),
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: _sizeImageItem,
          width: _sizeImageItem,
          child: DottedBorder(
            color: mColorDottedBorder,
            radius: Radius.circular(4.w),
            dashPattern: [5, 3],
            child: Center(
              child: Icon(
                Icons.add,
                size: 32.w,
                color: mColorIconGreen,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
