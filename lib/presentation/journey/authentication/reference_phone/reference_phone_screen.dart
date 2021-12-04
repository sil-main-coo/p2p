import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/data/model/response/sign_in_response.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/journey/app_pick/app_pick_route.dart';
import 'package:p2p_borrower/presentation/journey/authentication/reference_phone/widgets/reference_form_widget.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_contact_action.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/layout/big_title_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

import 'cubit/reference_phone_cubit.dart';

class ReferencePhoneScreen extends StatelessWidget {
  const ReferencePhoneScreen({Key? key, this.user}) : super(key: key);

  final User? user;

  void _showReferencePhoneFailureDialog(
      BuildContext context, ReferencePhoneFailure state) {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: SConfig.current.error,
        message: state.msg,
        rightLabel: S.current.tryAgain,
        callBackRight: () => Navigator.pop(context));
  }

  void _handlingWhenReferenceSuccess(
      BuildContext context, ReferencePhoneSuccess state) {
    // push to home screen
    Navigator.pushReplacementNamed(
      context,
      AppPickRoute.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarContactAction.noSignIn(
          automaticallyImplyLeading: false,
        ),
        body: BlocConsumer<ReferencePhoneCubit, ReferencePhoneState>(
          listener: (context, state) {
            if (state is ReferencePhoneFailure) {
              _showReferencePhoneFailureDialog(context, state);
              return;
            }

            if (state is ReferencePhoneSuccess) {
              _handlingWhenReferenceSuccess(context, state);
              return;
            }
          },
          builder: (context, state) {
            return _bodyReferencePhoneWidget(context);
          },
        ));
  }

  Widget _bodyReferencePhoneWidget(BuildContext context) {
    return BigTitleLayout(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          VerticalSpace.init32(),
          _title(context),
          VerticalSpace.init32(),
          ReferencePhoneFormWidget(
            user: user,
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
          S.current.referencePhone,
          style: titleStyle,
        ),
        VerticalSpace.init16(),
        Text(
          '${S.current.referencePhoneDescription}',
          style: messageStyle,
        ),
      ],
    );
  }
}
