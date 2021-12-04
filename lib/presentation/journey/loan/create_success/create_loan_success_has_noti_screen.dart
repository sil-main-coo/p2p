import 'package:flutter/material.dart';
import 'package:p2p_borrower/generated/l10n.dart';

import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/common/components/buttons/gradient_button.dart';
import 'package:p2p_borrower/presentation/common/components/layout/big_title_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';

class CreateLoanSuccessHasNotifyScreen extends StatelessWidget {
  const CreateLoanSuccessHasNotifyScreen({Key? key}) : super(key: key);

  void _backHome(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.textBigTitle;
    final messageStyle = Theme.of(context).textTheme.textDescriptionGreyNormal;

    return Scaffold(
        body: BigTitleLayout(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpace(
          height: 72,
        ),
        Text(
          S.current.sendLoanProfileSuccess,
          style: titleStyle,
        ),
        VerticalSpace.init16(),
        Text(
          S.current.sendLoanProfileSuccessMsg,
          style: messageStyle,
        ),
        VerticalSpace.init32(),
        RaisedGradientButton(
          label: S.current.backHome,
          onPressed: () => _backHome(context),
        )
      ],
    )));
  }
}
