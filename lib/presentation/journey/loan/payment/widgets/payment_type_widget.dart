import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/generated/l10n.dart';

class PaymentTypeWidget extends StatefulWidget {
  const PaymentTypeWidget({Key? key}) : super(key: key);

  @override
  _PaymentTypeWidgetState createState() => _PaymentTypeWidgetState();
}

class _PaymentTypeWidgetState extends State<PaymentTypeWidget> {
  final _data = [0, 1];
  int? _groupValue;

  @override
  void initState() {
    super.initState();
    _groupValue = _data[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.choosePaymentType,
          style: Theme.of(context).textTheme.textLabelTextField,
        ),
        VerticalSpace.init8(),
        _paymentTypeContainer(
          label: '${S.current.payThisMonth}\n${S.current.deadline}: 15/08/2018',
          totalAmount: '189.900đ',
          radioValue: _data[0],
          contents: [
            _moneyValue(S.current.principalAmount, '150.000đ'),
            _moneyValue(S.current.interestAmount, '30.000đ'),
            _moneyValue(S.current.transferFees, '9.900đ')
          ],
        ),
        VerticalSpace.init8(),
        _paymentTypeContainer(
          label: S.current.fullPaymentAdvance,
          totalAmount: '2.309.900đ',
          radioValue: _data[1],
          contents: [
            _moneyValue(S.current.principalAmount, '1.800.000đ'),
            _moneyValue(S.current.interestAmount, '300.000đ'),
            _moneyValue(S.current.prepaymentFees, '200.000đ'),
            _moneyValue(S.current.transferFees, '9.900đ')
          ],
        )
      ],
    );
  }

  Widget _paymentTypeContainer(
      {required List<Widget> contents,
      required int radioValue,
      required label,
      required String totalAmount}) {
    final isSelected = radioValue == _groupValue;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() {
          _groupValue = radioValue;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            border: Border.all(
                color: isSelected ? mColorBorderGreen : mColorBordersLines)),
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyText1,
                )),
                SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: Radio<int>(
                      value: radioValue,
                      groupValue: _groupValue,
                      onChanged: (value) {
                        setState(() {
                          _groupValue = value;
                        });
                      }),
                ),
              ],
            ),
            VerticalSpace.init16(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: contents,
                    )),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${S.current.amount}:',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          totalAmount,
                          style: Theme.of(context)
                              .textTheme
                              .textValueListTile
                              .copyWith(color: mColorBodyTextGreen),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _moneyValue(String label, String value) {
    return Text(
      '$label: $value',
      style: Theme.of(context).textTheme.caption,
    );
  }
}
