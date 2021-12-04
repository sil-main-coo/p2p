import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:p2p_borrower/data/model/response/multi_signin_message_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/cubits/authentication_cubit/authentication_cubit.dart';
import 'action_dialogs.dart';

class MultiSignInMessageDialog {
  static final MultiSignInMessageDialog _instance =
      MultiSignInMessageDialog._internal();

  MultiSignInMessageDialog._internal();

  BuildContext? _ct;

  bool get isShow => _ct != null; // check is showing

  static MultiSignInMessageDialog get instance => _instance;

  void showDefault(BuildContext childContext,
      MultiSignInMessageResponse response, BuildContext? globalContext) {
    _ct = globalContext;
    ActionDialogs.showAction(
        context: _ct!,
        barrierDismissible: false,
        message: '${S.current.multiSignInDescription1} '
            '${response.loginDeviceId}. '
            '${S.current.multiSignInDescription2} xxx '
            '${S.current.multiSignInDescription3}',
        rightLabel: S.current.signOut,
        callBackRight: () {
          _ct = null;
          BlocProvider.of<AuthenticationCubit>(childContext).signedOut();
        },
        leftLabel: S.current.contactUs,
        callBackLeft: () {});
  }
}
