import 'package:flutter/material.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton(
      {Key? key, this.textColor, required this.label, required this.onPressed})
      : super(key: key);

  final Function onPressed;
  final String label;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          onPressed();
        },
        child: Text(
          label,
          style:
              Theme.of(context).textTheme.buttonText.copyWith(color: textColor),
        ));
  }
}
