import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p2p_borrower/common/constants/icon_constants.dart';
import 'package:p2p_borrower/presentation/common/components/bottom_sheets/bottom_sheet_default/contact_support_bottom_sheet.dart';

enum AppbarType { NO_SIGN_IN, HOME }

// ignore: must_be_immutable
class AppbarContactAction extends StatelessWidget
    implements PreferredSizeWidget {
  late AppbarType _appbarType;

  AppbarContactAction.noSignIn({
    Key? key,
    this.automaticallyImplyLeading = true,
  }) : super(key: key) {
    _appbarType = AppbarType.NO_SIGN_IN;
  }

  AppbarContactAction.home(
      {Key? key,
      this.automaticallyImplyLeading = false,
      this.centerTitle = true})
      : super(key: key) {
    _appbarType = AppbarType.HOME;
  }

  final bool automaticallyImplyLeading;
  Widget? title;
  List<Widget>? actions;
  bool? centerTitle;

  void _onPressContactAction(BuildContext context) {
    ContactSupportBottomSheet.show(context);
  }

  @override
  Widget build(BuildContext context) {
    switch (_appbarType) {
      case AppbarType.NO_SIGN_IN:
        this.actions = [
          IconButton(
              icon: SvgPicture.asset(
                IconConstants.icDetail,
              ),
              onPressed: () => _onPressContactAction(context))
        ];
        break;
      case AppbarType.HOME:
        this.title = SvgPicture.asset(IconConstants.icLogoHome);
        actions = [
          IconButton(
              icon: SvgPicture.asset(
                IconConstants.icDetail,
              ),
              onPressed: () => _onPressContactAction(context))
        ];
        break;
    }

    return WillPopScope(
      onWillPop: () async {
        // unFocus text field
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
        return true;
      },
      child: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: title,
        actions: actions,
        centerTitle: centerTitle,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Platform.isAndroid ? 56.h : 48.h);
}
