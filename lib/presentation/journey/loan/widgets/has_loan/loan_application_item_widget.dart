import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p2p_borrower/common/constants/loan_application_status_constants.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';

import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/common/components/items/container_borders/circle_border_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';
import 'loan_application_option_menu.dart';

class LoanApplicationItemWidget extends StatelessWidget {
  LoanApplicationItemWidget({Key? key, required this.item}) : super(key: key);

  LoanApplicationResponse? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          border: Border.all(color: mColorBordersLines)),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _iconWidget(),
          HorizontalSpace.init8(),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleWidget(context),
              VerticalSpace.init4(),
              _subTitle(context)
            ],
          )),
          HorizontalSpace.init8(),
          LoanApplicationOptionMenu(
            item: item,
          )
        ],
      ),
    );
  }

  Widget _iconWidget() {
    return CircleBorderWidget(
        width: 32.w,
        height: 32.w,
        padding: 8.w,
        child: SvgPicture.network(
          item!.iconPath!,
          cacheColorFilter: true,
          color: mColorBodyText,
        ));
  }

  Widget _titleWidget(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.textTitleBodySize;

    return Text(
      item!.loanProduct!,
      style: titleStyle,
    );
  }

  Widget _subTitle(BuildContext context) {
    final subTitleStyle = Theme.of(context).textTheme.bodyText1;
    final captionStyle = Theme.of(context).textTheme.textDescriptionGreyNormal;

    String? subLabel, subValue1, subValue2;
    Color? colorOfSubValue1;

    switch (item?.status) {
      case LoanApplicationStatus.Draft:
      case LoanApplicationStatus.Submitted:
      case LoanApplicationStatus.UpdateRequired:
      case LoanApplicationStatus.MoreInfoRequired:
      case LoanApplicationStatus.Reject:
      case LoanApplicationStatus.InterestRateConfirm:
        subLabel = '${S.current.duration} ';
        subValue1 = '${item!.loanDuration} ${item!.durationUnitTranslated}';
        subValue2 = ' - ${item!.loanAmountActualFormatted}';
        break;
      case LoanApplicationStatus.OnMarket:
      case LoanApplicationStatus.FundRaised:
        subLabel = '${S.current.raised}: ';
        subValue1 = '${item!.raisedAmountFormattedWithoutCurrency}';
        subValue2 = ' / ${item!.loanAmountActualFormatted}';

        if (item!.isRaisedEnough || item!.isEnoughToDisbursement) {
          colorOfSubValue1 = mColorBodyTextGreen;
        }
        break;
      case LoanApplicationStatus.FundOvertime:
        subLabel = '${S.current.raised}: ';
        subValue1 = '${item!.raisedAmountFormattedWithoutCurrency}';
        subValue2 = ' / ${item!.loanAmountActualFormatted}';

        if (item!.isRaisedEnough || item!.isEnoughToDisbursement) {
          colorOfSubValue1 = mColorBodyTextGreen;
        } else {
          colorOfSubValue1 = mColorBad;
        }
        break;
      case LoanApplicationStatus.DisburmentPending:
      case LoanApplicationStatus.OnLoan:
        subLabel = '${S.current.amountLoan}: ';
        subValue1 = '${item!.loanAmountActualFormatted}';
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: '${S.current.status}: ',
              style: subTitleStyle,
              children: [
                TextSpan(
                  text: item!.statusText,
                  style: subTitleStyle!.copyWith(color: item!.statusColor),
                )
              ]),
        ),
        VerticalSpace.init4(),
        RichText(
          text: TextSpan(text: subLabel, style: captionStyle, children: [
            TextSpan(
              text: subValue1,
              style: captionStyle.copyWith(color: colorOfSubValue1),
            ),
            if (subValue2 != null)
              TextSpan(
                text: subValue2,
                style: captionStyle,
              )
          ]),
        ),
      ],
    );
  }
}
