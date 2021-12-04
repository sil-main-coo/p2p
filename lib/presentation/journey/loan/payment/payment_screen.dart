import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_step_action.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/gradient_button.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';

import 'widgets/payment_type_widget.dart';
import 'widgets/payment_with_widget.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarAction(
        titleText: S.current.pay,
        callbackLeading: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              PaymentTypeWidget(),
              VerticalSpace.init32(),
              PaymentWithWidget(),
              VerticalSpace.init64(),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: RaisedGradientButton(
          label: S.current.pay,
          onPressed: () {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
