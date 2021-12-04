import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/package_widgets/introduction_screen/src/model/page_view_model.dart';

class IntroContent extends StatelessWidget {
  final PageViewModel page;
  final bool isFullScreen;

  const IntroContent({Key? key, required this.page, this.isFullScreen = false})
      : super(key: key);

  Widget _buildWidget(Widget? widget, String? text, TextStyle style) {
    return widget ?? Text(text!, style: style, textAlign: TextAlign.center);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpace(
          height: 42.h,
        ),
        _buildWidget(
          page.titleWidget,
          page.title,
          page.decoration.titleTextStyle,
        ),
        VerticalSpace.init16(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 28.w),
          child: _buildWidget(
            page.bodyWidget,
            page.body,
            page.decoration.bodyTextStyle,
          ),
        ),
      ],
    );
  }
}
