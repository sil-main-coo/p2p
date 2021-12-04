import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:p2p_borrower/presentation/common/styles/style.dart';

class CircleBorderWidget extends StatelessWidget {
  const CircleBorderWidget(
      {Key? key,
      this.padding,
      required this.width,
      required this.height,
      required this.child})
      : super(key: key);

  final double height, width;
  final double? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width,
      width: height,
      alignment: Alignment.center,
      padding: EdgeInsets.all(padding ?? 16.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          width: 1,
          color: mColorBordersLines,
        ),
      ),
      child: child,
    );
  }
}
