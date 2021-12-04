import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2p_borrower/common/constants/icon_constants.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/items/list_tiles/app_list_tile_menu_navigator.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/journey/connect_to_social/connect_social_route.dart';
import 'package:p2p_borrower/presentation/journey/connect_to_social/cubit/connect_social_cubit.dart';

class ConnectFacebookMenu extends StatelessWidget {
  ConnectFacebookMenu({Key? key}) : super(key: key);

  bool _isConnected = false;

  @override
  Widget build(BuildContext context) {
    final connectSocialState = context.watch<ConnectSocialCubit>().state;

    if (connectSocialState is ConnectSocialLogged) {
      _isConnected = true;
    }

    return AppListTileMenuNavigator(
      title: S.current.connectFacebook,
      callBack: () =>
          Navigator.pushNamed(context, ConnectSocialRoute.connectFacebookID),
      value: _isConnected ? S.current.connected : null,
      valueColor: _isConnected ? mColorBodyTextGreen : null,
      hideTopBorder: true,
      leadingIcon: IconConstants.icFacebookMenu,
    );
  }
}
