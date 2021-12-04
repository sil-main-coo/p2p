import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';

import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class AppListTileNavigatorWidget extends StatelessWidget {
  const AppListTileNavigatorWidget(
      {Key? key,
      this.actionIcon,
      this.paddingIcon,
      this.colorBgIcon,
      required this.leadingIcon,
      required this.label,
      required this.title,
      required this.callBack})
      : super(key: key);

  final Function callBack;
  final Widget leadingIcon;
  final String label;
  final String title;
  final Color? colorBgIcon;
  final EdgeInsetsGeometry? paddingIcon;
  final Widget? actionIcon;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.bodyText1;

    return GestureDetector(
      onTap: () {
        callBack();
      },
      behavior: HitTestBehavior.translucent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.textLabelTextField,
          ),
          VerticalSpace.init8(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
            decoration: BoxDecoration(
                border: Border.all(color: mColorBordersLines),
                borderRadius: BorderRadius.all(Radius.circular(8.w))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.w)),
                          color: colorBgIcon),
                      padding: paddingIcon ?? EdgeInsets.all(8.w),
                      width: 30.w,
                      height: 30.w,
                      child: leadingIcon,
                    ),
                    HorizontalSpace.init16(),
                    Text(
                      title,
                      style: titleStyle,
                    )
                  ],
                ),
                actionIcon ?? Icon(
                  Icons.arrow_forward_ios,
                  size: 18.w,
                  color: mColorPlaceholder,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
