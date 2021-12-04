import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class VerticalSpace extends StatelessWidget {
  double height;

  VerticalSpace({required this.height});

  VerticalSpace.init4() : height = 4;

  VerticalSpace.init8() : height = 8;

  VerticalSpace.init16() : height = 16;

  VerticalSpace.init32() : height = 32;

  VerticalSpace.init48() : height = 48;

  VerticalSpace.init64() : height = 64;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.height.h,
    );
  }
}
