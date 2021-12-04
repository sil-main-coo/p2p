import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/services.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/common/constants/verify_constants.dart';
import 'package:p2p_borrower/data/model/response/phone_verify_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_contact_action.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/layout/big_title_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

import '../authentication_route.dart';
import 'cubit/input_phone_cubit.dart';
import 'widgets/form_input_phone_widget.dart';

class InputPhoneScreen extends StatelessWidget {
  void _handlingPhoneIsExist(BuildContext context,
      PhoneVerifyResponse phoneVerifyResponse, String phone) {
    if (phoneVerifyResponse.isInvestorExist!) {
      print('>>> show alert dialog');
      // todo: show alert dialog
    } else {
      // push to login screen
      Navigator.pushNamed(context, AuthenticationRoute.signInID,
          arguments: {AuthenticationRoute.phoneArg: phone});
    }
  }

  void _handlingPhoneNotExist(BuildContext context, InputPhoneNotExist state) {
    // push to otp screen
    Navigator.pushNamed(context, AuthenticationRoute.verifyOtpID, arguments: {
      AuthenticationRoute.phoneArg: state.phone,
      AuthenticationRoute.verifyTypeArg: VerifyConstants.Registration
    });
  }

  void _handlingInputPhoneFailure(
    BuildContext context,
    InputPhoneFailure state,
  ) {
    // show failure
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: SConfig.current.error,
        message: state.msg,
        rightLabel: S.current.tryAgain,
        callBackRight: () => Navigator.pop(context));
  }

  void _showPhoneBlockedDialog(BuildContext context) {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: SConfig.current.error,
        message: S.current.MSG06,
        rightLabel: S.current.OK,
        callBackRight: () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppbarContactAction.noSignIn(),
          body: BlocConsumer<InputPhoneCubit, InputPhoneState>(
            listener: (context, state) {
              if (state.isOTPLock) {
                // phone was locked
                _showPhoneBlockedDialog(context);
                return;
              }

              if (state is InputPhoneIsExist) {
                _handlingPhoneIsExist(
                    context, state.phoneVerifyResponse, state.phone!);
                return;
              }

              if (state is InputPhoneNotExist) {
                // push to otp screen
                _handlingPhoneNotExist(context, state);
                return;
              }

              if (state is InputPhoneFailure) {
                // showDialog
                _handlingInputPhoneFailure(context, state);
                return;
              }
            },
            builder: (_, __) => BigTitleLayout(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  VerticalSpace(height: 60.h),
                  _title(context),
                  FormInputPhoneWidget(),
                  VerticalSpace.init16(),
                  _bottomMessage(context),
                ],
              ),
            ),
          )),
    );
  }

  Widget _title(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.textBigTitle;
    final messageStyle = Theme.of(context).textTheme.textDescriptionGreyNormal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.loginInputPhoneTitle,
          style: titleStyle,
        ),
        VerticalSpace.init16(),
        Text(
          S.current.loginInputPhoneSubTitle,
          style: messageStyle,
        )
      ],
    );
  }

  Widget _bottomMessage(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: S.current.loginMessageLeadTermsText,
        style: Theme.of(context).textTheme.caption,
        children: <TextSpan>[
          TextSpan(
              text: ' ${S.current.termOfUse} ',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: mColorBodyTextGreen)),
          TextSpan(text: S.current.ofFinSmart),
        ],
      ),
    );
  }
}
