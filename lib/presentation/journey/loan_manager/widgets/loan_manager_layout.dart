import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/layout/compact_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class LoanManagerLayout extends StatelessWidget {
  const LoanManagerLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CompactLayout(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.currentLoans,
          style: Theme.of(context).textTheme.textLabelTextField,
        ),
        VerticalSpace.init8(),
        ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) => _loanItem(context, true),
            separatorBuilder: (_, __) => VerticalSpace.init8(),
            itemCount: 1),
        VerticalSpace.init32(),
        Text(
          S.current.endLoans,
          style: Theme.of(context).textTheme.textLabelTextField,
        ),
        VerticalSpace.init8(),
        ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) => _loanItem(context, false),
            separatorBuilder: (_, __) => VerticalSpace.init8(),
            itemCount: 3),
      ],
    ));
  }

  Widget _loanItem(BuildContext context, bool onLoan) {
    String label;
    String status;
    String amount;
    int loanDuration;
    String loanPurpose;
    Color? colorStatus;

    if (onLoan) {
      label = '08/05/2018';
      status = 'Đang vay';
      amount = '2.000.000đ';
      loanDuration = 3;
      loanPurpose = 'Vay mua xe máy';
      colorStatus = mColorBodyTextGreen;
    } else {
      label = '08/05/2018';
      status = 'Đã kết thúc';
      amount = '8.000.000đ';
      loanDuration = 12;
      loanPurpose = 'Vay mua điện thoại';
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            border: Border.all(color: mColorBordersLines)),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.textTitleBodySize,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          amount,
                          style: Theme.of(context)
                              .textTheme
                              .textValueListTileSemiBold,
                        ),
                      ),
                      HorizontalSpace.init8(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18.w,
                        color: mColorPlaceholder,
                      )
                    ],
                  ),
                )
              ],
            ),
            VerticalSpace.init4(),
            RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    text: '${S.current.status}: ',
                    children: [
                  TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: colorStatus),
                    text: status,
                  )
                ])),
            VerticalSpace.init4(),
            Text(
              '${S.current.duration} $loanDuration ${S.current.month}'
              ' - '
              '$loanPurpose',
              style: Theme.of(context).textTheme.textDescriptionGreyNormal,
            )
          ],
        ),
      ),
    );
  }
}
