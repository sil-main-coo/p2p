import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_contact_action.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/layout/big_title_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

import '../authentication_route.dart';
import 'cubit/forgot_password_cubit.dart';
import 'widgets/forgot_password_form_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen(
      {Key? key, required this.phone, required this.verifiedCode})
      : super(key: key);

  final String phone;
  final String verifiedCode;

  void _showForgotPasswordDialog(
      BuildContext context, ForgotPasswordFailure state) {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: SConfig.current.error,
        message: state.msg,
        rightLabel: S.current.tryAgain,
        callBackRight: () => Navigator.pop(context));
  }

  void _handlingForgotPasswordSuccess(
      BuildContext context, ForgotPasswordSuccess state) {
    /// push to sign in screen
    Navigator.pushNamedAndRemoveUntil(
        context, AuthenticationRoute.signInID, (route) => false,
        arguments: {AuthenticationRoute.phoneArg: phone});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarContactAction.noSignIn(
        automaticallyImplyLeading: false,
      ),
      body: _bodyForgotPwdWidget(context),
    );
  }

  Widget _bodyForgotPwdWidget(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordFailure) {
          _showForgotPasswordDialog(context, state);
          return;
        }

        if (state is ForgotPasswordSuccess) {
          _handlingForgotPasswordSuccess(context, state);
          return;
        }
      },
      builder: (context, state) {
        return BigTitleLayout(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              VerticalSpace.init16(),
              _title(context),
              VerticalSpace.init32(),
              ForgotPasswordFormWidget(phone: phone, verifiedCode: verifiedCode)
            ],
          ),
        );
      },
    );
  }

  Widget _title(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.textBigTitle;
    final messageStyle = Theme.of(context).textTheme.textDescriptionGreyNormal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.forgotPasswordTitle,
          style: titleStyle,
        ),
        VerticalSpace.init16(),
        Text(
          '${S.current.forgotPasswordDescription1} $phone, ${S.current.forgotPasswordDescription2}',
          style: messageStyle,
        ),
      ],
    );
  }
}
