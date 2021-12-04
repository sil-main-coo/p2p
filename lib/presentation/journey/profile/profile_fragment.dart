import 'package:flutter/material.dart';
import 'package:flutter_configuration_module/utility/utils/utils.dart';
import 'package:p2p_borrower/common/constants/app_default_constants.dart';
import 'package:p2p_borrower/common/constants/icon_constants.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/items/list_tiles/app_list_tile_menu_navigator.dart';
import 'package:p2p_borrower/presentation/common/components/layout/compact_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';

import 'widgets/connect_facebook_menu.dart';
import 'widgets/profile_header_widget.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CompactLayout(
      child: Column(
        children: [
          VerticalSpace.init16(),
          ProfileHeaderWidget(),
          VerticalSpace.init32(),
          ConnectFacebookMenu(),
          _menusContainer(context)
        ],
      ),
    );
  }

  Widget _menusContainer(BuildContext context) {
    return Column(
      children: [
        AppListTileMenuNavigator(
          title: S.current.changePassword,
          callBack: () {},
          hideTopBorder: true,
          leadingIcon: IconConstants.icLock,
        ),
        AppListTileMenuNavigator(
          title: S.current.calculatorSchedulePayment,
          callBack: () {},
          hideTopBorder: true,
          leadingIcon: IconConstants.icCalculator,
        ),
        AppListTileMenuNavigator(
          title: '${S.current.callHotline} (${AppDefaultConstants.HOTLINE})',
          callBack: () => Utils.callPhone(AppDefaultConstants.HOTLINE),
          hideTopBorder: true,
          leadingIcon: IconConstants.icCall,
        ),
        AppListTileMenuNavigator(
          title:
              '${S.current.supportMail} (${AppDefaultConstants.MAIL_SUPPORT})',
          callBack: () => Utils.sendEmail(AppDefaultConstants.MAIL_SUPPORT),
          hideTopBorder: true,
          leadingIcon: IconConstants.icMail,
        ),
        AppListTileMenuNavigator(
          title: S.current.frequentlyAskedQuestions,
          callBack: () {},
          hideTopBorder: true,
          leadingIcon: IconConstants.icHelp,
        ),
        AppListTileMenuNavigator(
          title: S.current.referenceAccount,
          callBack: () {},
          hideTopBorder: true,
          leadingIcon: IconConstants.icReference,
        ),
        AppListTileMenuNavigator(
          title: S.current.termsOfUse,
          callBack: () {},
          hideTopBorder: true,
          leadingIcon: IconConstants.icTerms,
        ),
        AppListTileMenuNavigator(
          title: S.current.introduction,
          callBack: () {},
          hideTopBorder: true,
          leadingIcon: IconConstants.icInfo,
        ),
        AppListTileMenuNavigator(
          title: S.current.signOut,
          callBack: () {},
          hideTopBorder: true,
          hideBottomBorder: true,
          leadingIcon: IconConstants.icLogout,
        )
      ],
    );
  }
}
