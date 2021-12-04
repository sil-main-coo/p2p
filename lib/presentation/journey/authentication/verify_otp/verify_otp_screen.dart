import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/common/constants/verify_constants.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/journey/authentication/verify_otp/otp_cubit/otp_constants.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/loading_dialog.dart';
import 'package:p2p_borrower/presentation/common/components/layout/big_title_layout.dart';
import 'package:p2p_borrower/presentation/common/components/snack_bar/app_snack_bar.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/cubits/validator_cubit/validator_cubit.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../authentication_route.dart';
import 'otp_box_widget/otp_buttons.dart';
import 'otp_box_widget/otp_title_widget.dart';
import 'otp_box_widget/pin_input_textfield/pin_input_text_field.dart';
import 'otp_box_widget/pin_input_textfield/src/widget/pin_widget.dart';
import 'otp_cubit/otp_cubit.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({Key? key, required this.typeOTP}) : super(key: key);

  /// Type verify otp
  final String typeOTP;

  /// PinInputTextFormField form-key
  final GlobalKey<FormFieldState<String>> _formKey =
      GlobalKey<FormFieldState<String>>(debugLabel: '_formkey');

  /// Control the input text field.
  final TextEditingController _pinEditingController = TextEditingController();

  void _verifySuccess(BuildContext context, String phone, String verifyCode) {
    switch (typeOTP) {
      case VerifyConstants.Registration:
        // push to registration
        Navigator.pushNamedAndRemoveUntil(
            context, AuthenticationRoute.signUpID, (route) => false,
            arguments: {
              AuthenticationRoute.phoneArg: phone,
              AuthenticationRoute.verifyCodeArg: verifyCode
            });
        break;
      case VerifyConstants.ResetPassword:
        // push to forgot password screen
        Navigator.pushNamedAndRemoveUntil(
            context, AuthenticationRoute.forgotPasswordID, (route) => false,
            arguments: {
              AuthenticationRoute.phoneArg: phone,
              AuthenticationRoute.verifyCodeArg: verifyCode
            });
        break;
      case VerifyConstants.CreateLoan:
        // back to review loan screen and return otp
        Navigator.pop(context, verifyCode);
        break;
      case VerifyConstants.SignContract:
      // back to review loan screen and return otp
        Navigator.pop(context, verifyCode);
        break;
    }
  }

  void _clearOTPFields(BuildContext context) {
    _pinEditingController.clear();
    context.read<ValidatorCubit>().validateVerifyOtp("");
  }

  void _autoVerifyOTP(BuildContext context, String otp) {
    AppSnackBar.show(context, otp);
  }

  void _showPhoneBlockedDialog(
      BuildContext context, String msg, bool isSignedIn, String phone) {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: S.current.verifyOTPFailureTitle,
        message: msg,
        rightLabel: S.current.OK,
        callBackRight: () {
          // if signed in -> push to sign in
          // else -> push to input phone screen
          isSignedIn
              ? Navigator.pushNamedAndRemoveUntil(
                  context, AuthenticationRoute.signInID, (route) => false,
                  arguments: {AuthenticationRoute.phoneArg: phone})
              : Navigator.pushNamedAndRemoveUntil(
                  context, AuthenticationRoute.inputPhoneID, (route) => false);
        });
  }

  void _showSendOTPFailureDialog(BuildContext context, String msg) {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: SConfig.current.failure,
        message: msg,
        rightLabel: S.current.tryAgain,
        callBackRight: () => Navigator.pop(context));
  }

  void _showVerifyOTPFailureDialog(BuildContext context, String msg) {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: S.current.verifyOTPFailureTitle,
        message: msg,
        rightLabel: S.current.tryAgain,
        callBackRight: () {
          _clearOTPFields(context);
          Navigator.pop(context);
        });
  }

  void _showOTPSentDialog(BuildContext context, String otp) {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        message: S.current.resendOTPSuccess,
        rightLabel: S.current.OK,
        callBackRight: () => Navigator.pop(context));
    _autoVerifyOTP(context, otp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<OtpCubit, OtpState>(
          listener: (context, state) {
            if (state is OtpLoading) {
              getIt.get<AppLoadingDialog>().showDefault(context);
            }
            if (state is OtpIsSent) {
              getIt.get<AppLoadingDialog>().popDialog();
              _autoVerifyOTP(context, state.otp!);
            }
            if (state is OtpIsReSent) {
              getIt.get<AppLoadingDialog>().popDialog();
              _showOTPSentDialog(context, state.otp!);
            }
            if (state is OtpSendFailure) {
              getIt.get<AppLoadingDialog>().popDialog();
              state.isLocked
                  ? _showPhoneBlockedDialog(
                      context, state.msg, state.isSignedIn, state.phone!)
                  : _showSendOTPFailureDialog(context, state.msg);
            }
            if (state is VerifyOTPFailed) {
              (state.isLocked)
                  ? _showPhoneBlockedDialog(
                      context, state.msg, state.isSignedIn, state.phone!)
                  : _showVerifyOTPFailureDialog(context, state.msg);
            }
            if (state is VerifyOTPSuccess) {
              _verifySuccess(context, state.phone, state.verifyCode);
            }
          },
          builder: (_, otpState) => BigTitleLayout(
            child: ListView(
              children: [
                VerticalSpace(height: 58.h),
                OTPTitleWidget(),
                VerticalSpace(height: 24.h),
                _formInputOtpWidget(otpState)
              ],
            ),
          ),
        ));
  }

  Widget _otpFieldWidget(BuildContext context, OtpState otpState) {
    return Container(
      height: 42.h,
      padding: EdgeInsets.symmetric(horizontal: 96.w),
      child: PinInputTextFormField(
        key: _formKey,
        enabled: otpState is VerifyOtpLoading ? false : true,
        pinLength: OTPConstants.lengthCode,
        decoration: NoBorderDecoration(
            hintText: '------',
            textStyle: Theme.of(context).textTheme.textFieldOTP,
            gapSpace: 32.w,
            hintTextStyle: Theme.of(context)
                .textTheme
                .textFieldOTP
                .copyWith(color: mColorDescription)),
        controller: _pinEditingController,
        textInputAction: TextInputAction.go,
        autoFocus: true,
        keyboardType: TextInputType.number,
        textCapitalization: TextCapitalization.characters,
        onChanged: (otp) {
          context.read<ValidatorCubit>().validateVerifyOtp(otp);
        },
      ),
    );
  }

  Widget _formInputOtpWidget(OtpState otpState) {
    return BlocBuilder<ValidatorCubit, ValidatorState>(
      builder: (context, validateState) {
        return Column(
          children: [
            _otpFieldWidget(context, otpState),
            VerticalSpace(height: 24.h),
            OtpButtons()
          ],
        );
      },
    );
  }
}
