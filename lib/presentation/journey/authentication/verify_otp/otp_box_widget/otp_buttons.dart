import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/journey/authentication/verify_otp/otp_cubit/otp_cubit.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/app_text_button.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/gradient_button.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/cubits/timer_cubit/timer_cubit.dart';
import 'package:p2p_borrower/presentation/cubits/validator_cubit/validator_cubit.dart';

class OtpButtons extends StatelessWidget {
  const OtpButtons({Key? key}) : super(key: key);

  void _resendOtp(BuildContext context) {
    BlocProvider.of<OtpCubit>(context).resendOtp();
  }

  void _verifyOtp(BuildContext context, String otp) {
    if (otp.isNotEmpty) {
      context.read<OtpCubit>()..verifyOtp(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final otpBloc = context.read<OtpCubit>();
    final validatorState = context.read<ValidatorCubit>().state;

    return Column(
      children: [
        otpBloc.state is VerifyOtpLoading
            ? RaisedGradientButton.loading(
                onPressed: () {},
              )
            : RaisedGradientButton(
                child: Text(
                  S.current.verifyOTPAccept,
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: validatorState.isValid
                    ? () => _verifyOtp(context, validatorState.value!)
                    : null,
              ),
        VerticalSpace.init16(),
        BlocBuilder<TimerCubit, TimerState>(
          bloc: otpBloc.timerCubit,
          builder: (context, TimerState state) {
            return Visibility(
              visible: state is TimerRunComplete && otpBloc.getCountSendOTP > 0,
              child: AppTextButton(
                  onPressed: otpBloc.state is VerifyOtpLoading
                      ? () {}
                      : () => _resendOtp(context),
                  label: S.current.verifyOTPResend),
            );
          },
        )
      ],
    );
  }
}
