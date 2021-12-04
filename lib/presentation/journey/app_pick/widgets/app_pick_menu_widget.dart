import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:p2p_borrower/common/constants/icon_constants.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/journey/home/home_route.dart';

class AppPickMenuWidget extends StatefulWidget {
  const AppPickMenuWidget({Key? key}) : super(key: key);

  @override
  _AppPickMenuWidgetState createState() => _AppPickMenuWidgetState();
}

class _AppPickMenuWidgetState extends State<AppPickMenuWidget> {
  void _showInvestorAppAlertDialog() {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: S.current.switchInvestorAppTitle,
        message: S.current.switchInvestorAppMsg,
        leftLabel: S.current.cancel1,
        callBackLeft: () => Navigator.pop(context),
        rightLabel: S.current.accept,
        callBackRight: () {
          // todo: link to investor app
        });
  }

  void _pushToHome() {
    Navigator.pushNamedAndRemoveUntil(context, HomeRoute.id, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          _menuItemWidget(
              onTap: _pushToHome,
              icon: IconConstants.icBorrowerPick,
              isSelected: true,
              title: S.current.appPickMenuBorrowerTitle,
              description: S.current.appPickMenuBorrowerDescription),
          HorizontalSpace.init8(),
          _menuItemWidget(
              onTap: _showInvestorAppAlertDialog,
              icon: IconConstants.icInvestorPick,
              title: S.current.appPickMenuInvestorTitle,
              description: S.current.appPickMenuInvestorDescription),
        ],
      ),
    );
  }

  Widget _menuItemWidget(
      {bool isSelected = false,
      required String icon,
      required String title,
      required String description,
      Function()? onTap}) {
    final titleStyle = Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(color: isSelected ? Colors.white : mColorBodyText);
    final descriptionStyle = Theme.of(context)
        .textTheme
        .caption!
        .copyWith(color: isSelected ? mColorBordersLines : null);
    final selectTextStyle = Theme.of(context).textTheme.caption!.copyWith(
        color: isSelected ? Colors.white : mColorBodyTextGreen,
        fontWeight: FontWeight.bold);

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 291.h,
        width: 172.w,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: ShapeDecoration(
            color: isSelected ? null : Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.w)),
            gradient: isSelected
                ? LinearGradient(
                    colors: [mColorHighlight, mColorGradient],
                  )
                : null),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VerticalSpace(
              height: 32,
            ),
            _circleBorderWidget(icon: icon, isSelected: isSelected),
            VerticalSpace.init32(),
            Text(
              title,
              style: titleStyle,
            ),
            VerticalSpace.init16(),
            SizedBox(
              height: 60.h,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: descriptionStyle,
              ),
            ),
            VerticalSpace(
              height: 32,
            ),
            Text(
              S.current.select.toUpperCase(),
              style: selectTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleBorderWidget({required bool isSelected, required String icon}) {
    return Container(
      height: 50.w,
      width: 50.w,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          width: 1,
          color: isSelected ? mColorBorderLinesLight : mColorBodyText,
        ),
      ),
      child: SvgPicture.asset(
        icon,
        color: isSelected ? Colors.white : mColorBodyText,
      ),
    );
  }
}
