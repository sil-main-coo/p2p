import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/generated/l10n.dart';

import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class CreateNewLoanItem extends StatelessWidget {
  const CreateNewLoanItem({Key? key, required this.createNewLoan})
      : super(key: key);

  final Function createNewLoan;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        createNewLoan();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.w),
            border: Border.all(color: mColorBordersLines)),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.add,
                size: 22.w,
                color: mColorDescription,
              ),
              VerticalSpace.init16(),
              Text(
                S.current.createNewLoan,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ),
        ),
      ),
    );
  }
}
