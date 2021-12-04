import 'package:flutter/material.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class AppOutLineButton extends StatelessWidget {
  const AppOutLineButton(
      {Key? key, required this.onPressed, required this.label})
      : super(key: key);

  final Function onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlineButton(
        borderSide: BorderSide(color: mColorBorderGreen),
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .button
              ?.copyWith(color: mColorBodyTextGreen),
        ),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
