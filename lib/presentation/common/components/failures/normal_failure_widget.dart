import 'package:flutter/material.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/app_text_button.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/gradient_button.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NormalFailureWidget extends StatelessWidget {
  const NormalFailureWidget(
      {Key? key,
      required this.onPressed,
      required this.message,
      required this.label,
      this.onPressed1,
      this.label1})
      : super(key: key);

  final Function() onPressed;
  final String label;
  final Function()? onPressed1;
  final String? label1;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          VerticalSpace(
            height: 24,
          ),
          RaisedGradientButton(label: label, onPressed: onPressed),
          VerticalSpace.init16(),
          if (label1 != null && onPressed1 != null)
            AppTextButton(label: label1!, onPressed: onPressed1!)
        ],
      ),
    );
  }
}
