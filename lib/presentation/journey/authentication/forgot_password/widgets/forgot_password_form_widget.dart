import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/common/constants/app_default_constants.dart';

import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/journey/authentication/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/gradient_button.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_textfield.dart';
import 'package:p2p_borrower/presentation/cubits/validator_cubit/validator_cubit.dart';

class ForgotPasswordFormWidget extends StatefulWidget {
  const ForgotPasswordFormWidget(
      {Key? key, required this.phone, required this.verifiedCode})
      : super(key: key);

  final String phone;
  final String verifiedCode;

  @override
  _ForgotPasswordFormWidgetState createState() =>
      _ForgotPasswordFormWidgetState();
}

class _ForgotPasswordFormWidgetState extends State<ForgotPasswordFormWidget> {
  final TextEditingController _ctrlPwd = new TextEditingController();
  final TextEditingController _ctrlConfirmPwd = new TextEditingController();

  final FocusNode _fcPwd = FocusNode();
  final FocusNode _fcConfirmPwd = FocusNode();

  void _registerAccount(String phone, String password, String verifiedCode,
      ForgotPasswordCubit forgotPasswordCubit) async {
    await forgotPasswordCubit.forgotPassword(phone, password, verifiedCode);
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
    final forgotPasswordCubit = BlocProvider.of<ForgotPasswordCubit>(context);

    return BlocBuilder<ValidatorCubit, ValidatorState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField.passwordOnlyDigits(
              key: ValueKey('key-pwd'),
              isRedTextWhenError: false,
              controller: _ctrlPwd,
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
            (forgotPasswordCubit.state is ForgotPasswordLoading)
                ? RaisedGradientButton.loading(
                    onPressed: () {},
                  )
                : RaisedGradientButton(
                    onPressed: state.isValid
                        ? () => _registerAccount(
                            widget.phone,
                            _ctrlPwd.text.trim(),
                            widget.verifiedCode,
                            forgotPasswordCubit)
                        : null,
                    label: S.current.confirm,
                  ),
          ],
        );
      },
    );
  }
}
