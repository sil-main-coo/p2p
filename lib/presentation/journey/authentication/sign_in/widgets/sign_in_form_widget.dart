import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/common/constants/app_default_constants.dart';
import 'package:p2p_borrower/common/constants/verify_constants.dart';

import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/journey/authentication/sign_in/cubit/sign_in_cubit.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/app_text_button.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/gradient_button.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_textfield.dart';
import 'package:p2p_borrower/presentation/cubits/validator_cubit/validator_cubit.dart';
import '../../authentication_route.dart';

class SignInFormWidget extends StatefulWidget {
  const SignInFormWidget({Key? key, required this.phone}) : super(key: key);

  final String phone;

  @override
  _SignInFormWidgetState createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  final TextEditingController _ctrlPwd = new TextEditingController();

  void _signInAccount(
      String phone, String password, SignInCubit signInCubit) async {
    await signInCubit.signIn(phone, password);
  }

  void _showForgotPasswordDialog() {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: S.current.resetPassword,
        message:
            '${S.current.sendOTPDescription1} ${widget.phone} ${S.current.sendOTPDescription2}',
        leftLabel: S.current.cancel1,
        callBackLeft: () => Navigator.pop(context),
        rightLabel: S.current.accept,
        callBackRight: () {
          // push to otp screen
          Navigator.pushNamed(context, AuthenticationRoute.verifyOtpID,
              arguments: {
                AuthenticationRoute.phoneArg: widget.phone,
                AuthenticationRoute.verifyTypeArg: VerifyConstants.ResetPassword
              });
        });
  }

  @override
  void dispose() {
    super.dispose();
    _ctrlPwd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInCubit = BlocProvider.of<SignInCubit>(context);

    return BlocBuilder<ValidatorCubit, ValidatorState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField.passwordOnlyDigits(
              key: ValueKey('key-pwd'),
              isRedTextWhenError: false,
              controller: _ctrlPwd,
              autofocus: true,
              labelText: S.current.password,
              hintText: S.current.hintPassword,
              errorMaxLines: 2,
              maxLen: AppDefaultConstants.appPasswordLength,
              errorText: state.errors != null && state.errors![0]!.isNotEmpty
                  ? state.errors![0]
                  : null,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                context.read<ValidatorCubit>().validateInputPassword(
                      value,
                    );
              },
            ),
            VerticalSpace(height: 28.h),
            (signInCubit.state is SignInLoading)
                ? RaisedGradientButton.loading(
                    onPressed: () {},
                  )
                : RaisedGradientButton(
                    onPressed: state.isValid
                        ? () => _signInAccount(
                            widget.phone, _ctrlPwd.text.trim(), signInCubit)
                        : null,
                    label: S.current.confirm,
                  ),
            VerticalSpace.init16(),
            Center(
              child: AppTextButton(
                  onPressed: _showForgotPasswordDialog,
                  label: '${S.current.forgotPassword}?'),
            ),
          ],
        );
      },
    );
  }
}
