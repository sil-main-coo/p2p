import 'package:flutter/material.dart';
import 'package:p2p_borrower/presentation/common/components/layout/compact_layout.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';

import 'notification_item_widget.dart';

class NotificationLayout extends StatelessWidget {
  const NotificationLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CompactLayout(
        child: ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) => NotificationItemWidget(index == 0),
            separatorBuilder: (_, __) => VerticalSpace.init8(),
            itemCount: 6));
  }
}
