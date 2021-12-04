import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconButton extends StatelessWidget {
  const SvgIconButton(
      {Key? key,
      required this.iconPath,
      required this.onTap,
      required this.iconColor,
      required this.size})
      : super(key: key);

  final Function onTap;
  final double size;
  final String iconPath;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: size,
        height: size,
        child: SvgPicture.asset(
          iconPath,
          color: iconColor,
          width: size,
          height: size,
        ),
      ),
    );
  }
}
