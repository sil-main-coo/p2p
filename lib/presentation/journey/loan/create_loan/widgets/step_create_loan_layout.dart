import 'package:flutter/material.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_step_action.dart';

class StepCreateLoanLayout extends StatelessWidget {
  const StepCreateLoanLayout(
      {Key? key,
      required this.body,
      required this.title,
      required this.subTitle,
      required this.backStep,
      this.nextStep})
      : super(key: key);

  final Widget body;
  final String title, subTitle;
  final Function backStep;
  final Function? nextStep;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return backStep() ?? false;
      },
      child: Scaffold(
        appBar: AppbarAction(
          titleText: title,
          subTitleText: subTitle,
          callbackLeading: () {
            backStep();
          },
          textAction: S.current.next,
          callbackAction: nextStep != null
              ? () {
                  nextStep!();
                }
              : null,
        ),
        body: body,
      ),
    );
  }
}
