import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/generated/l10n.dart';

class PaymentWithWidget extends StatefulWidget {
  const PaymentWithWidget({Key? key}) : super(key: key);

  @override
  _PaymentWithWidgetState createState() => _PaymentWithWidgetState();
}

class _PaymentWithWidgetState extends State<PaymentWithWidget> {
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
        ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              IconData icon;
              String title;
              String description;

              if (index == 0) {
                icon = Icons.memory;
                title = 'Thanh toán online qua Bảo Kim';
                description =
                    'Chuyển khoản qua Bảo Kim để thanh toán khoản tiền này. Số tiền phí chuyển khoản là 9.900đ cho mỗi lần giao dịch.';
              } else {
                icon = Icons.payment;
                title = 'Sử dụng ATM nội địa';
                description =
                    'Bạn sẽ được chuyển qua website napas.com.vn để hoàn tất quá trình thanh toán';
              }

              return _paymentServiceContainer(
                  icon: icon,
                  title: title,
                  description: description,
                  radioValue: _data[index]);
            },
            separatorBuilder: (_, __) => VerticalSpace.init8(),
            itemCount: 2)
      ],
    );
  }

  Widget _paymentServiceContainer(
      {required IconData icon,
      required String title,
      required String description,
      required int radioValue}) {
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 16.w,
            ),
            HorizontalSpace.init16(),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                VerticalSpace.init4(),
                Text(
                  description,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
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
      ),
    );
  }
}
