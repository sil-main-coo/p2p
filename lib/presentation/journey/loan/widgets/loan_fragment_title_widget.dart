import 'package:flutter/material.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/layout/big_title_layout.dart';

import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';

class LoanFragmentTitleWidget extends StatelessWidget {
  const LoanFragmentTitleWidget(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  final String title, description;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.textBigTitle;
    final messageStyle = Theme.of(context).textTheme.textDescriptionGreyNormal;

    return BigTitleLayout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalSpace(
            height: 24,
          ),
          Text(
            '${S.current.welcome}!',
            style: titleStyle,
          ),
          Text(
            title,
            style: titleStyle,
          ),
          VerticalSpace.init16(),
          Text(
            description,
            style: messageStyle,
          ),
          VerticalSpace.init16(),
        ],
      ),
    );
  }
}
