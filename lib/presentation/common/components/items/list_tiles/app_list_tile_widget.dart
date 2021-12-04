import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class AppListTileWidget extends StatelessWidget {
  const AppListTileWidget(
      {Key? key,
      required this.title,
      required this.value,
      this.titleFlex = 1,
      this.valueFlex = 1,
      this.verticalAlign = CrossAxisAlignment.start,
      this.hideTopBorder = false,
      this.paddingZero = false,
      this.hideBottomBorder = false})
      : super(key: key);

  final Widget title;
  final Widget value;
  final bool hideTopBorder;
  final bool hideBottomBorder;
  final bool paddingZero;
  final int titleFlex, valueFlex;
  final CrossAxisAlignment verticalAlign;

  @override
  Widget build(BuildContext context) {
    final border = BorderSide(width: 1, color: mColorBordersLines);

    final borderSetup = (hideTopBorder && hideBottomBorder)
        ? null
        : (!hideTopBorder && !hideBottomBorder)
            ? Border.symmetric(horizontal: border)
            : hideTopBorder
                ? Border(bottom: border)
                : Border(top: border);

    return Padding(
      padding: paddingZero
          ? EdgeInsets.zero
          : EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: paddingZero
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          border: borderSetup,
        ),
        child: Row(
          crossAxisAlignment: verticalAlign,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(flex: titleFlex, child: title),
            HorizontalSpace.init8(),
            Expanded(flex: valueFlex, child: value)
          ],
        ),
      ),
    );
  }
}
