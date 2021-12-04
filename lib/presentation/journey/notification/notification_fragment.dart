import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:p2p_borrower/common/constants/icon_constants.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_step_action.dart';
import 'package:p2p_borrower/presentation/common/components/dropdown_menu/dropdown_menu_model.dart';
import 'package:p2p_borrower/presentation/common/components/dropdown_menu/dropdown_with_arrow.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

import 'widgets/notification_layout.dart';

class NotificationFragment extends StatelessWidget {
  const NotificationFragment({Key? key}) : super(key: key);

  void _markAllAsRead(BuildContext context) {
    // todo: impl code here
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;

    return Scaffold(
      appBar: AppbarAction(
        titleText: S.current.notification,
        actions: isEmpty
            ? null
            : [
                DropDownWithArrow(
                  textTitle: S.current.additionalOption,
                  childrenModel: [
                    DropDownMenuModel(
                        onPressed: () => _markAllAsRead(context),
                        label: S.current.markAllAsRead,
                        color: mColorBodyTextGreen),
                  ],
                  widthBox: 360.w,
                  backgroundColor: Colors.white,
                  icon: IconButton(
                      icon: SvgPicture.asset(
                        IconConstants.icDetail,
                      ),
                      onPressed: null),
                )
              ],
      ),
      body: isEmpty ? _emptyNotificationWidget(context) : NotificationLayout(),
    );
  }

  Widget _emptyNotificationWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.w),
      child: Center(
        child: Text(
          S.current.notificationEmptyMsg,
          style: Theme.of(context).textTheme.textSub,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
