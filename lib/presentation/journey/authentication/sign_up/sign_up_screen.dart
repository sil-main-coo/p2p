import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';

import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/journey/authentication/authentication_route.dart';
import 'package:p2p_borrower/presentation/journey/authentication/sign_in/cubit/sign_in_cubit.dart';
import 'package:p2p_borrower/presentation/journey/authentication/sign_up/cubit/sign_up_cubit.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_contact_action.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/layout/big_title_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

import 'widgets/sign_up_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen(
      {Key? key, required this.phone, required this.verifiedCode})
      : super(key: key);

  final String phone;
  final String verifiedCode;

  void _showSignUpFailureDialog(BuildContext context, SignUpFailure state) {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: SConfig.current.error,
        message: state.msg,
        rightLabel: S.current.tryAgain,
        callBackRight: () => Navigator.pop(context));
  }

  void _showSignInFailureDialog(BuildContext context, SignInFailure state) {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: SConfig.current.error,
        message: state.msg,
        rightLabel: S.current.tryAgain,
        callBackRight: () => Navigator.pop(context));
  }

  void _handlingSignUpSuccess(BuildContext context, SignUpSuccess state) {
    // handling call sign in api and save cache account if sign in success
    BlocProvider.of<SignInCubit>(context)
        .signIn(phone, state.password, autoPush: false);
  }

  void _handlingWhenSignedIn(BuildContext context, SignInSuccess state) {
    // push to reference phone screen
    Navigator.pushReplacementNamed(
        context, AuthenticationRoute.referencePhoneID,
        arguments: {
          AuthenticationRoute.userArg: state.signInResponse.user,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppbarContactAction.noSignIn(
          automaticallyImplyLeading: false,
        ),
        body: _listenerSignInCubit(context));
  }

  Widget _listenerSignInCubit(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listener: (context, state) {
        if (state is SignInFailure) {
          _showSignInFailureDialog(context, state);
          return;
        }

        if (state is SignInSuccess) {
          _handlingWhenSignedIn(context, state);
          return;
        }
      },
      builder: (_, __) => _bodySignUpWidget(context),
    );
  }

  Widget _bodySignUpWidget(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          _showSignUpFailureDialog(context, state);
          return;
        }

        if (state is SignUpSuccess) {
          _handlingSignUpSuccess(context, state);
          return;
        }
      },
      builder: (context, state) {
        return BigTitleLayout(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              VerticalSpace(
                height: 16,
              ),
              _title(context),
              VerticalSpace(
                height: 32,
              ),
              SignUpFormWidget(phone: phone, verifiedCode: verifiedCode)
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
          S.current.signUpTitle,
          style: titleStyle,
        ),
        VerticalSpace.init16(),
        Text(
          '${S.current.signUpDescription1} $phone, ${S.current.signUpDescription2}',
          style: messageStyle,
        ),
      ],
    );
  }
}
