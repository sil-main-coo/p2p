import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class AppListTileMenuNavigator extends StatelessWidget {
  const AppListTileMenuNavigator(
      {Key? key,
      this.value,
      this.valueColor,
      required this.leadingIcon,
      required this.title,
      required this.callBack,
      this.hideTopBorder = false,
      this.hideBottomBorder = false})
      : super(key: key);

  final Function callBack;
  final String leadingIcon;
  final String title;
  final String? value;
  final Color? valueColor;
  final bool hideTopBorder;
  final bool hideBottomBorder;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.bodyText1;
    final border = BorderSide(width: 1, color: mColorBordersLines);

    final borderSetup = (hideTopBorder && hideBottomBorder)
        ? null
        : (!hideTopBorder && !hideBottomBorder)
            ? Border.symmetric(horizontal: border)
            : hideTopBorder
                ? Border(bottom: border)
                : Border(top: border);

    return GestureDetector(
      onTap: () {
        callBack();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.w),
        decoration: BoxDecoration(
          border: borderSetup,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 22.w,
                  width: 22.w,
                  child: SvgPicture.asset(
                    leadingIcon,
                  ),
                ),
                HorizontalSpace.init32(),
                RichText(
                    text: TextSpan(text: title, style: titleStyle, children: [
                  if (value != null)
                    TextSpan(
                        text: ': $value',
                        style: titleStyle!.copyWith(color: valueColor))
                ])),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18.w,
              color: mColorPlaceholder,
            )
          ],
        ),
      ),
    );
  }
}
