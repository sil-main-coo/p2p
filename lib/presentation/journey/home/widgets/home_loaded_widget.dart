import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:p2p_borrower/common/constants/icon_constants.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/acttion_payment_screen_enum.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/linking_payment_fragment.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/journey/loan/loan_fragment.dart';
import 'package:p2p_borrower/presentation/journey/loan_manager/loan_manager_fragment.dart';
import 'package:p2p_borrower/presentation/journey/notification/notification_fragment.dart';
import 'package:p2p_borrower/presentation/journey/profile/profile_fragment.dart';

class HomeLoadedWidget extends StatefulWidget {
  HomeLoadedWidget({Key? key}) : super(key: key);

  @override
  _HomeLoadedWidgetState createState() => _HomeLoadedWidgetState();
}

class _HomeLoadedWidgetState extends State<HomeLoadedWidget> {
  final _fragments = <Widget>[
    LoanFragment(),
    LoanManagerFragment(),
    LinkingPaymentFragment(
      action: ActionPaymentScreenEnum.MANAGER,
    ),
    NotificationFragment(),
    ProfileFragment()
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .caption!
        .copyWith(fontWeight: FontWeight.bold);

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _fragments,
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            _tabItemWidget(IconConstants.icBorrow, IconConstants.icBorrowFocus,
                S.current.loan),
            _tabItemWidget(IconConstants.icLoanManager,
                IconConstants.icLoanManagerFocus, S.current.loanManager),
            _tabItemWidget(IconConstants.icWallet, IconConstants.icWalletFocus,
                S.current.account),
            _tabItemWidget(IconConstants.icNotify, IconConstants.icNotifyFocus,
                S.current.notification,
                haveAction: true),
            _tabItemWidget(IconConstants.icProfile,
                IconConstants.icProfileFocus, S.current.profile),
          ],
          onTap: _onItemTapped,
          selectedItemColor: mColorGradient,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: textStyle,
          unselectedLabelStyle: textStyle,
          currentIndex: _selectedIndex),
    );
  }

  BottomNavigationBarItem _tabItemWidget(
      String icon, String activeIcon, String label,
      {bool haveAction = false}) {
    return BottomNavigationBarItem(
      icon: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 22.w,
            height: 22.w,
            child: SvgPicture.asset(
              icon,
            ),
          ),
          if (haveAction)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 10.w,
                height: 10.w,
                decoration: ShapeDecoration(
                    color: mColorBad,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
              ),
            )
        ],
      ),
      activeIcon: SizedBox(
        width: 22.w,
        height: 22.w,
        child: SvgPicture.asset(
          activeIcon,
        ),
      ),
      label: label,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
