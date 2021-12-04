import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class RaisedGradientButton extends StatelessWidget {
  final String? label;
  final Gradient? gradient;
  final double width;
  final double? height;
  final Function()? onPressed;
  final Widget? child;
  final bool isLoading;
  final IconData? icon;

  const RaisedGradientButton({
    Key? key,
    this.label,
    this.gradient,
    this.icon,
    this.width = double.infinity,
    this.height,
    this.isLoading = false,
    this.child,
    this.onPressed,
  }) : super(key: key);

  const RaisedGradientButton.icon({
    Key? key,
    required this.label,
    this.gradient,
    required this.icon,
    this.width = double.infinity,
    this.height,
    this.isLoading = false,
    this.child,
    this.onPressed,
  }) : super(key: key);

  const RaisedGradientButton.loading(
      {Key? key,
      this.label,
      this.gradient,
      this.icon,
      this.width = double.infinity,
      this.height,
      this.isLoading = true,
      this.child,
      this.onPressed})
      : super(key: key);

  const RaisedGradientButton.done({
    Key? key,
    this.label,
    this.gradient,
    this.icon,
    this.width = double.infinity,
    this.height,
    this.isLoading = false,
    this.child = const Icon(
      Icons.check,
      size: 24,
      color: mColorIconWhite,
    ),
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed == null ? null : onPressed!,
        child: Container(
            width: width,
            height: height ?? 44.0.h,
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(dimen_4)),
                gradient: onPressed == null
                    ? null
                    : gradient ??
                        LinearGradient(
                          colors: [mColorHighlight, mColorGradient],
                        ),
                color: onPressed == null ? mButtonColorNoActive : null),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      height: 16.w,
                      width: 16.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        color: mColorHighlight,
                        backgroundColor: Colors.white,
                      ))
                  : child ??
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (icon != null)
                            Icon(
                              icon,
                              size: 18.w,
                              color: Colors.white,
                            ),
                          HorizontalSpace.init4(),
                          Text(
                            label!,
                            style: Theme.of(context).textTheme.button,
                          ),
                        ],
                      ),
            )),
      ),
    );
  }
}
