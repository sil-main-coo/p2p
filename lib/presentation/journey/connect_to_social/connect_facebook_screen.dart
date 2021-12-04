import 'package:flutter/material.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_step_action.dart';
import 'package:p2p_borrower/presentation/journey/connect_to_social/connect_facebook_layout.dart';

class ConnectFacebookScreen extends StatelessWidget {
  const ConnectFacebookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarAction(
        titleText: S.current.connectFacebook,
      ),
      body: ConnectFacebookLayout(),
    );
  }
}
