import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/gradient_button.dart';

class LoanManagerEmptyLayout extends StatelessWidget {
  const LoanManagerEmptyLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Center(
          child: Text(
            S.current.loanManagerEmpty,
            style: Theme.of(context).textTheme.textSub,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: RaisedGradientButton.icon(
          onPressed: () {},
          label: S.current.createLoan,
          icon: Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
