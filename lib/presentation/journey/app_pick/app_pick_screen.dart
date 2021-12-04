import 'package:flutter/material.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/journey/app_pick/widgets/app_pick_menu_widget.dart';

import 'package:p2p_borrower/presentation/common/components/appbars/appbar_contact_action.dart';
import 'package:p2p_borrower/presentation/common/components/layout/big_title_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

class AppPickScreen extends StatelessWidget {
  const AppPickScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarContactAction.home(
        automaticallyImplyLeading: false,
        // centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          BigTitleLayout(
            child: Column(
              children: [
                VerticalSpace.init32(),
                _title(context),
              ],
            ),
          ),
          VerticalSpace(height: 62,),
          AppPickMenuWidget()
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
          S.current.appPickTitle,
          style: titleStyle,
        ),
        VerticalSpace.init16(),
        Text(
          S.current.appPickDescription,
          style: messageStyle,
        ),
      ],
    );
  }
}
