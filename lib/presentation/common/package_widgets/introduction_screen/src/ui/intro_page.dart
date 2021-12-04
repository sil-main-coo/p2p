import 'package:flutter/material.dart';
import '../model/page_view_model.dart';
import 'intro_content.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ReversedList<T> on List<T> {
  List<T> asReversed(bool reverse) {
    return reverse ? this.reversed.toList() : this;
  }
}

class IntroPage extends StatefulWidget {
  final PageViewModel page;
  final ScrollController? scrollController;
  final bool isTopSafeArea;
  final bool isBottomSafeArea;

  const IntroPage({
    Key? key,
    required this.page,
    this.scrollController,
    required this.isTopSafeArea,
    required this.isBottomSafeArea,
  }) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Widget _buildFlex() {
    return SizedBox(
      height: ScreenUtil().screenHeight,
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (widget.page.image != null)
              Align(
                alignment: widget.page.decoration.imageAlignment,
                child: widget.page.image,
              ),
            IntroContent(page: widget.page),
          ].asReversed(widget.page.reverse),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SafeArea(
      child: _buildFlex(),
    );
  }
}
