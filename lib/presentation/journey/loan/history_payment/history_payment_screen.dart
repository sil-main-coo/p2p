import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_step_action.dart';
import 'package:p2p_borrower/presentation/common/components/layout/compact_layout.dart';
import 'package:p2p_borrower/presentation/common/components/layout/platform_layout_constants.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class HistoryPaymentScreen extends StatelessWidget {
  HistoryPaymentScreen({Key? key}) : super(key: key);

  final _sizeCircleMilestone = 30.w;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarAction(
          titleText: S.current.repaymentSchedule,
          callbackLeading: ()=> Navigator.pop(context),
        ),
        body: Stack(
          children: [_verticalLine(), _scheduleListItem(context)],
        ));
  }

  Widget _verticalLine() {
    return Positioned(
        left: PlatformLayoutConstants.marginCompactLayout +
            _sizeCircleMilestone / 2,
        child: Container(
          width: 1.w,
          height: ScreenUtil().screenHeight,
          color: mColorBordersLines,
        ));
  }

  Widget _scheduleListItem(BuildContext context) {
    return CompactLayout(
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          bool? isOverTime = index > 8
              ? false
              : index == 8
                  ? true
                  : null;

          late Color borderColor;
          late Color amountColor;
          late Color textColor;
          late Color bgColor;
          late String status;
          late Color iconColor;
          late IconData icon;

          if (isOverTime == null) {
            // not due yet
            icon = Icons.access_time;
            borderColor = mColorTabBarBg;
            amountColor = mColorDescription;
            bgColor = mColorTabBarBg;
            textColor = mColorBodyText;
            status = S.current.notDueYet;
            iconColor = mColorBodyText;
          } else if (isOverTime) {
            // over
            icon = Icons.error_outline;
            borderColor = mColorBad;
            amountColor = mColorBad;
            iconColor = mColorBad;
            bgColor = mColorTabBarBg;
            textColor = mColorBodyText;
            status = S.current.needPaymentNow;
          } else {
            // paid
            icon = Icons.check;
            borderColor = mColorBgPaidGreen;
            amountColor = Colors.white;
            iconColor = Colors.white;
            bgColor = mColorBgPaidGreen;
            textColor = Colors.white;
            status = S.current.paid;
          }

          return Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _milestoneIcon(
                    context: context,
                    icon: icon,
                    borderColor: borderColor,
                    bgColor: bgColor,
                    iconColor: iconColor),
                HorizontalSpace.init8(),
                _milestoneCard(
                    context: context,
                    status: status,
                    bgColor: bgColor,
                    amountColor: amountColor,
                    borderColor: borderColor,
                    textColor: textColor)
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => VerticalSpace.init8(),
      ),
    );
  }

  Widget _milestoneIcon(
      {required BuildContext context,
      required IconData icon,
      Color? borderColor,
      Color? iconColor,
      Color? bgColor}) {
    return Container(
        width: _sizeCircleMilestone,
        height: _sizeCircleMilestone,
        alignment: Alignment.center,
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
            color: bgColor ?? mColorTabBarBg,
            border: Border.all(color: borderColor ?? mColorTabBarBg),
            borderRadius: BorderRadius.circular(90)),
        child: Icon(
          icon,
          color: iconColor ?? mColorBodyText,
          size: 16.w,
        ));
  }

  Widget _milestoneCard(
      {required BuildContext context,
      required String status,
      required Color bgColor,
      required Color borderColor,
      required Color textColor,
      required Color amountColor}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(
              8.w,
            ),
            border: Border.all(color: borderColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kỳ x',
              style: Theme.of(context)
                  .textTheme
                  .textLabelTextField
                  .copyWith(color: textColor),
            ),
            VerticalSpace.init4(),
            Text('15/09/2018',
                style: Theme.of(context)
                    .textTheme
                    .textTitleBodySize
                    .copyWith(color: textColor)),
            VerticalSpace.init4(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: Text(status,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: textColor)),
                ),
                Flexible(
                  flex: 1,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('1.125.000đ',
                        style: Theme.of(context)
                            .textTheme
                            .textValueListTile
                            .copyWith(color: amountColor)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
