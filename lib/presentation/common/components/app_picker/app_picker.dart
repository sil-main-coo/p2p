import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/generated/l10n.dart';

import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/horizontal_space_widget.dart';

class AppPicker extends StatelessWidget {
  const AppPicker({Key? key, required this.child, required this.onPressedDone})
      : super(key: key);

  final Widget child;
  final Function onPressedDone;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          color: Colors.white.withOpacity(0.8),
          height: 44.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => Navigator.pop(context),
                child: Container(
                  alignment: Alignment.center,
                  width: 52.w,
                  height: double.infinity,
                  child: Text(
                    S.current.cancel,
                    style: Theme.of(context).textTheme.textAction,
                  ),
                ),
              ),
              HorizontalSpace.init8(),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  onPressedDone();
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 52.w,
                  height: double.infinity,
                  child: Text(
                    S.current.save,
                    style: Theme.of(context).textTheme.textAction,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 218.h,
          child: child,
        ),
      ],
    );
  }
}
