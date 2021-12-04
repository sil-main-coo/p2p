import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/generated/l10n.dart';

import 'package:p2p_borrower/common/constants/app_default_constants.dart';
import 'package:p2p_borrower/data/model/request/reference_phone_request.dart';
import 'package:p2p_borrower/data/model/response/sign_in_response.dart';
import 'package:p2p_borrower/presentation/journey/app_pick/app_pick_route.dart';
import 'package:p2p_borrower/presentation/journey/authentication/reference_phone/cubit/reference_phone_cubit.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/app_text_button.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/gradient_button.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_textfield.dart';
import 'package:p2p_borrower/presentation/cubits/validator_cubit/validator_cubit.dart';

class ReferencePhoneFormWidget extends StatefulWidget {
  const ReferencePhoneFormWidget({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  _ReferencePhoneFormWidgetState createState() =>
      _ReferencePhoneFormWidgetState();
}

class _ReferencePhoneFormWidgetState extends State<ReferencePhoneFormWidget> {
  final TextEditingController _ctrlPwd = new TextEditingController();

  void _referencePhone(
      String phone, ReferencePhoneCubit referencePhoneCubit) async {
    await referencePhoneCubit
        .referencePhone(ReferencePhoneRequest(refererPhone: phone));
  }

  void _pushToHome() {
    // push to home screen
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppPickRoute.id,
      (route) => false,
    );
  }

  @override
  void dispose() {
    _ctrlPwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final referenceCubit = BlocProvider.of<ReferencePhoneCubit>(context);

    return BlocBuilder<ValidatorCubit, ValidatorState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField.phone(
              controller: _ctrlPwd,
              isRedTextWhenError: false,
              autofocus: true,
              hintText: S.current.referencePhoneHintField,
              errorMaxLines: 2,
              maxLen: AppDefaultConstants.MAX_PHONE_LEN,
              errorText: state.errors != null && state.errors![0]!.isNotEmpty
                  ? state.errors![0]
                  : null,
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                context
                    .read<ValidatorCubit>()
                    .validatePhoneReference(value, widget.user!.phone!);
              },
            ),
            VerticalSpace(height: 28.h),
            (referenceCubit.state is ReferencePhoneLoading)
                ? RaisedGradientButton.loading(
                    onPressed: () {},
                  )
                : RaisedGradientButton(
                    onPressed: state.isValid
                        ? () => _referencePhone(
                            _ctrlPwd.text.trim(), referenceCubit)
                        : null,
                    label: S.current.confirm,
                  ),
            VerticalSpace.init16(),
            Center(
              child: AppTextButton(
                  onPressed: _pushToHome, label: '${S.current.skip}'),
            ),
          ],
        );
      },
    );
  }
}
