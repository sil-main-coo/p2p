import 'package:flutter/material.dart';
import 'package:p2p_borrower/common/constants/loan_app_action_enum.dart';
import 'package:p2p_borrower/generated/l10n.dart';

import 'package:p2p_borrower/presentation/common/components/buttons/gradient_button.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';

import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/common/components/check_box/app_default_checkbox_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';

class ReviewLoanCheckBoxButtonWidget extends StatefulWidget {
  ReviewLoanCheckBoxButtonWidget(
      {Key? key,
      required this.phone,
      required this.buttonCallback,
      required this.loanAppActionEnum})
      : super(key: key) {
    switch (loanAppActionEnum) {
      case LoanAppActionEnum.UPDATE:
        _btnLabel = S.current.updateLoanProfile;
        break;
      default:
        _btnLabel = S.current.sendLoanProfile;
    }
  }

  final String phone;
  final Function buttonCallback;
  final LoanAppActionEnum loanAppActionEnum;
  late String _btnLabel;

  @override
  _ReviewLoanCheckBoxButtonWidgetState createState() =>
      _ReviewLoanCheckBoxButtonWidgetState();
}

class _ReviewLoanCheckBoxButtonWidgetState
    extends State<ReviewLoanCheckBoxButtonWidget> {
  bool _isValid = false;

  void _showSendLoanAlertDialog() {
    ActionDialogs.showAction(
        context: context,
        barrierDismissible: false,
        title: S.current.sendLoan,
        message:
            '${S.current.sendOTPDescription1} ${widget.phone} ${S.current.sendOTPDescription2}',
        leftLabel: S.current.cancel1,
        callBackLeft: () => Navigator.pop(context),
        rightLabel: S.current.accept,
        callBackRight: () async {
          Navigator.pop(context); // pop this dialog
          widget.buttonCallback();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _noteCheckBox(context),
        VerticalSpace.init16(),
        _sendProfileButton(),
      ],
    );
  }

  Widget _noteCheckBox(BuildContext context) {
    final labelStyle = Theme.of(context).textTheme.textDescriptionGreyNormal;

    return AppDefaultCheckboxWidget(
      onChanged: (value) {
        setState(() {
          _isValid = value!;
        });
      },
      labelWidget: RichText(
          text: TextSpan(
              style: labelStyle,
              text: '${S.current.agreeWith} ',
              children: [
            TextSpan(
              style: labelStyle.copyWith(color: mColorBodyTextGreen),
              text: S.current.loanTermsAndConditions,
            )
          ])),
    );
  }

  Widget _sendProfileButton() {
    return RaisedGradientButton(
      label: widget._btnLabel,
      onPressed: _isValid ? () => _showSendLoanAlertDialog() : null,
    );
  }
}
