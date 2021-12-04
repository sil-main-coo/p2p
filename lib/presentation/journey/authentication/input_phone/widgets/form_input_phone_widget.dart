import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/common/constants/app_default_constants.dart';
import 'package:p2p_borrower/common/constants/icon_constants.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/journey/authentication/input_phone/cubit/input_phone_cubit.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/gradient_button.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/components/textfield/app_textfield.dart';
import 'package:p2p_borrower/presentation/cubits/validator_cubit/validator_cubit.dart';


class FormInputPhoneWidget extends StatefulWidget {
  FormInputPhoneWidget({Key? key}) : super(key: key);

  @override
  _FormInputPhoneWidgetState createState() => _FormInputPhoneWidgetState();
}

class _FormInputPhoneWidgetState extends State<FormInputPhoneWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _sendPhone(BuildContext context, String phone,
      InputPhoneCubit inputPhoneCubit) async {
    await inputPhoneCubit.inputPhone(phone);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inputPhoneCubit = BlocProvider.of<InputPhoneCubit>(context);

    return BlocBuilder<ValidatorCubit, ValidatorState>(
      builder: (context, state) => Form(
        child: Column(
          children: [
            VerticalSpace(height: 40.h),
            AppTextField.phone(
              controller: _controller,
              focusNode: _focusNode,
              isRedTextWhenError: false,
              autofocus: true,
              maxLen: AppDefaultConstants.MAX_PHONE_LEN,
              prefixIcon: SvgPicture.asset(
                IconConstants.icVietnam,
              ),
              hintText: S.current.loginInputPhoneHint,
              errorText: state.errors != null ? state.errors![0] : null,
              onChanged: (value) {
                context.read<ValidatorCubit>().validatePhoneNumber(value);
              },
            ),
            VerticalSpace(height: 28.h),
            (inputPhoneCubit.state is InputPhoneLoading)
                ? RaisedGradientButton.loading(
                    onPressed: () {},
                  )
                : RaisedGradientButton(
                    onPressed: state.isValid
                        ? () => _sendPhone(
                            context, _controller.text.trim(), inputPhoneCubit)
                        : null,
                    label: S.current.continueText,
                  ),
          ],
        ),
      ),
    );
  }
}
