import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_configuration_module/utility/utils/utils.dart';
import 'package:p2p_borrower/common/constants/app_default_constants.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/cubits/authentication_cubit/authentication_cubit.dart';

import 'content_bottom_sheet_default.dart';

class ContactSupportBottomSheet {
  static AuthenticationState? _previousState;

  static void show(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.transparent,
        builder: (_) {
          return BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) => _bodyWidget(context, state),
          );
        });
  }

  static Widget _bodyWidget(BuildContext context, AuthenticationState state) {
    bool isSignedIn = (_previousState == null ||
            _previousState is SignedOutFailed ||
            _previousState is AuthenticatedAndNotSignIn ||
            _previousState is AuthenticatedAndSignedIn ||
            _previousState is AuthenticationLoading) &&
        (state is AuthenticationLoading ||
            state is AuthenticatedAndNotSignIn ||
            state is AuthenticatedAndSignedIn ||
            state is SignedOutFailed);
    _previousState = state;

    final buttons = [
      ButtonBottomSheetModel(
          label:
              '${S.current.emailSupport}: ${AppDefaultConstants.MAIL_SUPPORT}',
          color: Colors.black,
          onPressed: () => Utils.sendEmail(AppDefaultConstants.MAIL_SUPPORT)),
      ButtonBottomSheetModel(
          label: '${S.current.callHotline}: ${AppDefaultConstants.HOTLINE}',
          color: Colors.black,
          onPressed: () => Utils.callPhone(AppDefaultConstants.HOTLINE)),
      if (isSignedIn)
        ButtonBottomSheetModel(
            label: '${S.current.signOut}',
            color: mColorBad,
            onPressed: () async =>
                await BlocProvider.of<AuthenticationCubit>(context)
                    .signedOut()),
    ];

    return ContentBottomSheetDefault(
      title: isSignedIn ? S.current.option : S.current.support,
      buttons: buttons,
    );
  }
}
