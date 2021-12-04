import 'package:flutter/material.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:p2p_borrower/presentation/common/components/dialogs/widgets/app_alert_dialog_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/data/model/response/loan_products_response.dart';

class SelectLoanProductDialogWidget extends StatefulWidget {
  final List<LoanProductsResponse> loanProducts;
  final LoanProductsResponse loanProductSelected;
  final Function(LoanProductsResponse) callbackSelect;

  const SelectLoanProductDialogWidget(
      {Key? key,
      required this.loanProducts,
      required this.loanProductSelected,
      required this.callbackSelect})
      : super(key: key);

  @override
  _SelectLoanProductDialogWidgetState createState() =>
      _SelectLoanProductDialogWidgetState();
}

class _SelectLoanProductDialogWidgetState
    extends State<SelectLoanProductDialogWidget> {
  late LoanProductsResponse _itemSelected;

  @override
  void initState() {
    _itemSelected = widget.loanProductSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppAlertDialogWidget(
      title: S.current.purposeLoan,
      contentPadding: EdgeInsets.only(top: 16.h),
      barrierDismissible: false,
      leftLabel: S.current.cancel,
      callBackLeft: () => Navigator.pop(context),
      rightLabel: S.current.select,
      callBackRight: () {
        widget.callbackSelect(_itemSelected);
        Navigator.pop(context);
      },
      content: _loanProductRadios(),
    );
  }

  Widget _loanProductRadios() {
    return SizedBox(
      height: 344.h,
      width: double.maxFinite,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.loanProducts.length,
        itemBuilder: (context, index) =>
            _itemRadioWidget(widget.loanProducts[index]),
      ),
    );
  }

  Widget _itemRadioWidget(LoanProductsResponse loanProducts) {
    final titleStyle = Theme.of(context).textTheme.bodyText1;
    final subTitleStyle = Theme.of(context).textTheme.caption;

    return Padding(
      padding: EdgeInsets.only(top: 16.h, left: 24.w, right: 24.w),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            _itemSelected = loanProducts;
          });
        },
        child: Row(
          children: [
            SizedBox(
              height: 16.w,
              width: 16.w,
              child: Radio<LoanProductsResponse>(
                value: loanProducts,
                groupValue: _itemSelected,
                onChanged: (value) {},
              ),
            ),
            HorizontalSpace.init16(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loanProducts.name!,
                  style: titleStyle,
                ),
                VerticalSpace.init4(),
                Text(
                  loanProducts.getRangeAmountMoneyString(),
                  style: subTitleStyle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
