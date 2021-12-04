import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/common/constants/app_default_constants.dart';

import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/journey/authentication/sign_in/cubit/sign_in_cubit.dart';
import 'package:p2p_borrower/presentation/journey/authentication/sign_up/cubit/sign_up_cubit.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/gradient_button.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_textfield.dart';
import 'package:p2p_borrower/presentation/cubits/validator_cubit/validator_cubit.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget(
      {Key? key, required this.phone, required this.verifiedCode})
      : super(key: key);

  final String phone;
  final String verifiedCode;

  @override
  _SignUpFormWidgetState createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final TextEditingController _ctrlPwd = new TextEditingController();
  final TextEditingController _ctrlConfirmPwd = new TextEditingController();

  final FocusNode _fcPwd = FocusNode();
  final FocusNode _fcConfirmPwd = FocusNode();

  void _registerAccount(String phone, String password, String verifiedCode,
      SignUpCubit signUpCubit) async {
    await signUpCubit.signUp(phone, password, verifiedCode);
  }

  @override
  void dispose() {
    _ctrlPwd.dispose();
    _ctrlConfirmPwd.dispose();
    _fcPwd.dispose();
    _fcConfirmPwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpCubit = BlocProvider.of<SignUpCubit>(context);
    final signInCubit = BlocProvider.of<SignInCubit>(context);

    return BlocBuilder<ValidatorCubit, ValidatorState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField.passwordOnlyDigits(
              key: ValueKey('key-pwd'),
              controller: _ctrlPwd,
              isRedTextWhenError: false,
              focusNode: _fcPwd,
              autofocus: true,
              labelText: S.current.password,
              hintText: S.current.hintPassword,
              errorMaxLines: 2,
              maxLen: AppDefaultConstants.appPasswordLength,
              errorText: state.errors != null && state.errors![0]!.isNotEmpty
                  ? state.errors![0]
                  : null,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) => _fcConfirmPwd.requestFocus(),
              onChanged: (value) {
                context.read<ValidatorCubit>().validateConfirmPassword(
                    value, _ctrlConfirmPwd.text.trim());
              },
            ),
            VerticalSpace(
              height: 24,
            ),
            AppTextField.passwordOnlyDigits(
              key: ValueKey('key-confirm-pwd'),
              isRedTextWhenError: false,
              controller: _ctrlConfirmPwd,
              focusNode: _fcConfirmPwd,
              labelText:
                  '${S.current.confirm} ${S.current.password.toLowerCase()}',
              hintText: S.current.hintConfirmPassword,
              maxLen: AppDefaultConstants.appPasswordLength,
              errorMaxLines: 2,
              textInputAction: TextInputAction.done,
              errorText: state.errors != null && state.errors![1]!.isNotEmpty
                  ? state.errors![1]
                  : null,
              onChanged: (value) {
                context
                    .read<ValidatorCubit>()
                    .validateConfirmPassword(_ctrlPwd.text.trim(), value);
              },
            ),
            VerticalSpace(height: 28.h),
            (signUpCubit.state is SignUpLoading) ||
                    (signInCubit.state is SignInLoading)
                ? RaisedGradientButton.loading(
                    onPressed: () {},
                  )
                : RaisedGradientButton(
                    onPressed: state.isValid
                        ? () => _registerAccount(
                            widget.phone,
                            _ctrlPwd.text.trim(),
                            widget.verifiedCode,
                            signUpCubit)
                        : null,
                    label: S.current.confirm,
                  ),
          ],
        );
      },
    );
  }
}
