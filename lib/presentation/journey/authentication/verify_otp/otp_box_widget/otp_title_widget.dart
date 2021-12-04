import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:flutter_configuration_module/utility/extentions/integer_extension.dart';
import 'package:p2p_borrower/presentation/journey/authentication/verify_otp/otp_cubit/otp_cubit.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/cubits/timer_cubit/timer_cubit.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class OTPTitleWidget extends StatefulWidget {
  const OTPTitleWidget({Key? key}) : super(key: key);

  @override
  _OTPTitleWidgetState createState() => _OTPTitleWidgetState();
}

class _OTPTitleWidgetState extends State<OTPTitleWidget> {
  late TimerCubit timerCubit;

  @override
  void dispose() {
    timerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timerCubit = context.read<OtpCubit>().timerCubit;

    final titleStyle = Theme.of(context).textTheme.textBigTitle;
    final messageStyle = Theme.of(context).textTheme.textDescriptionGreyNormal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.verifyOTPTitle,
          style: titleStyle,
        ),
        VerticalSpace.init16(),
        BlocBuilder(
          bloc: timerCubit,
          builder: (context, TimerState state) {
            return RichText(
                text: TextSpan(
                    text: S.current.verifyOTPDescription,
                    style: messageStyle,
                    children: [
                  TextSpan(
                      text: " ${state.duration.toMinuteSecond}",
                      style: state.duration == 0
                          ? messageStyle.copyWith(color: mColorBad)
                          : messageStyle),
                ]));
          },
        ),
      ],
    );
  }
}
