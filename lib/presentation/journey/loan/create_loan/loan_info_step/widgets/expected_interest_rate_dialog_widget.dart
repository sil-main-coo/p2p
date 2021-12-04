import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/data/model/response/user_credit_rank_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/circle_icon_button.dart';
import 'package:p2p_borrower/presentation/common/components/items/list_tiles/app_list_tile_title_value_widget.dart';

class ExpectedInterestRateDialogWidget extends StatelessWidget {
  const ExpectedInterestRateDialogWidget(this.creditRanks, {Key? key})
      : super(key: key);

  final List<CreditRanks> creditRanks;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.subtitle1;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 68.h),
      elevation: 0,
      child: Container(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12.w))),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 16.h, left: 45.w, right: 45.w),
                      child: Text(
                        S.current.interestRateInfo,
                        style: titleStyle,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 24.w),
                          child: Column(
                              children: List.generate(
                            creditRanks.length,
                            (index) => AppListTileTitleValueWidget(
                                titleFlex: 1,
                                valueFlex: 2,
                                hideTopBorder: true,
                                titleLabel:
                                    '${S.current.rank} ${creditRanks[index].rank!}',
                                valueText:
                                    '${S.current.loanInterestRate} ${creditRanks[index].interestRate!}${creditRanks[index].unit!}'),
                          )),
                        ),
                      ),
                    ),
                  ],
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
                  callback: () => Navigator.pop(context),
                ))
          ],
        ),
      ),
    );
  }
}
