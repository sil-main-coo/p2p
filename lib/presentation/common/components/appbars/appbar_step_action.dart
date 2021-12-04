import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

// ignore: must_be_immutable
class AppbarAction extends StatelessWidget implements PreferredSizeWidget {
  AppbarAction(
      {Key? key,
      this.actions,
      required this.titleText,
      this.leadingWidget,
      this.callbackLeading,
      this.subTitleText,
      this.automaticallyImplyLeading = true,
      this.leadingTextButton,
      this.textAction,
      this.callbackAction})
      : super(key: key);

  final bool automaticallyImplyLeading;
  final String titleText;
  final String? subTitleText;
  final String? leadingTextButton;
  final Function? callbackLeading;
  final String? textAction;
  final List<Widget>? actions;
  final Function()? callbackAction;
  final Widget? leadingWidget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading
          ? null
          : leadingWidget ??
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  callbackLeading!();
                },
                child: leadingTextButton != null
                    ? TextButton(
                        onPressed: callbackLeading != null
                            ? () {
                                callbackLeading!();
                              }
                            : null,
                        child: Text(
                          leadingTextButton ?? '',
                          style: Theme.of(context).textTheme.textAction,
                        ),
                      )
                    : IconButton(
                        icon: Icon(Icons.arrow_back, color: mColorIconDark),
                        onPressed: () {
                          callbackLeading!();
                        },
                      ),
              ),
      title: Column(
        children: [
          Text(
            titleText,
            style: Theme.of(context).textTheme.textTitleAppbar,
          ),
          if (subTitleText != null)
            Text(
              subTitleText!,
              style: Theme.of(context).textTheme.caption,
            )
        ],
      ),
      actions: actions != null
          ? actions
          : [
              if (callbackAction != null && textAction != null)
                Padding(
                  padding: EdgeInsets.only(right: 8.0.w),
                  child: TextButton(
                    onPressed: callbackAction ?? null,
                    child: Text(
                      textAction ?? '',
                      style: Theme.of(context).textTheme.textAction,
                    ),
                  ),
                )
            ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Platform.isAndroid ? 56.h : 48.h);
}
