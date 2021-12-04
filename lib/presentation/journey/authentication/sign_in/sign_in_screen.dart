import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/generated/l10n.dart';

import 'package:p2p_borrower/presentation/journey/authentication/sign_in/cubit/sign_in_cubit.dart';
import 'package:p2p_borrower/presentation/journey/authentication/sign_in/widgets/sign_in_form_widget.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_contact_action.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/layout/big_title_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key, required this.phone}) : super(key: key);

  final String phone;

  void _showSignInFailureDialog(BuildContext context, SignInFailure state) {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: SConfig.current.error,
        message: state.msg,
        rightLabel: S.current.tryAgain,
        callBackRight: () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarContactAction.noSignIn(
          // automaticallyImplyLeading: false,
        ),
        body: BlocConsumer<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state is SignInFailure) {
              _showSignInFailureDialog(context, state);
              return;
            }
          },
          builder: (context, state) {
            return _bodySignInWidget(context);
          },
        ));
  }

  Widget _bodySignInWidget(BuildContext context) {
    return BigTitleLayout(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          VerticalSpace.init32(),
          _title(context),
          VerticalSpace.init32(),
          SignInFormWidget(
            phone: phone,
          )
        ],
      ),
    );
  }

  Widget _title(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.textBigTitle;
    final messageStyle = Theme.of(context).textTheme.textDescriptionGreyNormal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.signIn,
          style: titleStyle,
        ),
        VerticalSpace.init16(),
        Text(
          '${S.current.signInDescription1} $phone, ${S.current.signInDescription2}',
          style: messageStyle,
        ),
      ],
    );
  }
}
