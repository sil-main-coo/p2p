import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class HorizontalSpace extends StatelessWidget {
  double width;

  HorizontalSpace({required this.width});

  HorizontalSpace.init4() : width = 4;

  HorizontalSpace.init8() : width = 8;

  HorizontalSpace.init16() : width = 16;

  HorizontalSpace.init32() : width = 32;

  HorizontalSpace.init48() : width = 48;

  HorizontalSpace.init64() : width = 64;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: this.width.w,
    );
  }
}
