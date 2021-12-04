import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton(
      {Key? key,
      this.width,
      this.height,
      required this.icon,
      required this.iconColor,
      required this.bgColor,
      required this.callback,
      required this.borderColor})
      : super(key: key);

  final Color iconColor;
  final Color bgColor;
  final Color borderColor;
  final Function callback;
  final IconData icon;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        alignment: Alignment.center,
        width: width ?? 24.w,
        height: height ?? 24.w,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          border: Border.all(color: this.borderColor, width: 3.w),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 0,
              blurRadius: 5,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 16.w,
          color: iconColor,
        ),
      ),
    );
  }
}
