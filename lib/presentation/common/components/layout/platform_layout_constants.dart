import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlatformLayoutConstants {
  static final double marginBigTitleLayout = Platform.isIOS ? 32.w : 24.w;
  static final double marginCompactLayout = 16.w;
}
