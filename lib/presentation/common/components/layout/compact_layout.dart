import 'package:flutter/material.dart';

import 'platform_layout_constants.dart';

/// Based design
class CompactLayout extends StatelessWidget implements PlatformLayoutConstants {
  const CompactLayout(
      {Key? key, required this.child, this.paddingHorizontalZero = false})
      : super(key: key);

  final Widget child;
  final bool paddingHorizontalZero;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: paddingHorizontalZero
            ? EdgeInsets.symmetric(
                vertical: PlatformLayoutConstants.marginCompactLayout)
            : EdgeInsets.all(PlatformLayoutConstants.marginCompactLayout),
        child: child,
      ),
    );
  }
}
