import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:p2p_borrower/data/model/response/loan_products_response.dart';
import 'package:p2p_borrower/presentation/common/components/check_box/app_default_checkbox_widget.dart';
import 'package:p2p_borrower/presentation/journey/home/cubit/home_cubit.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/journey/loan/loan_route.dart';

class ConfirmBeforeCreateLoanDialog {
  static void showConfirmBeforeCreateLoan(
      BuildContext parentContext, LoanProductsResponse loanProductSelected) {
    showDialog(
        context: parentContext,
        barrierDismissible: false,
        builder: (context) => BlocProvider.value(
              value: BlocProvider.of<HomeCubit>(parentContext),
              child: _ConfirmBeforeCreateLoanWidget(
                loanProductSelected: loanProductSelected,
              ),
            ));
  }
}

class _ConfirmBeforeCreateLoanWidget extends StatefulWidget {
  const _ConfirmBeforeCreateLoanWidget(
      {Key? key, required this.loanProductSelected})
      : super(key: key);

  final LoanProductsResponse loanProductSelected;

  @override
  _ConfirmBeforeCreateLoanWidgetState createState() =>
      _ConfirmBeforeCreateLoanWidgetState();
}

class _ConfirmBeforeCreateLoanWidgetState
    extends State<_ConfirmBeforeCreateLoanWidget> {

  void _handleAccept() {
    Navigator.pop(context);

    final homeState = BlocProvider.of<HomeCubit>(context).state;
    if (homeState is HomeLoaded) {
      Navigator.pushNamed(context, LoanRoute.createLoanID, arguments: {
        LoanRoute.argLoanProducts: homeState.loanProducts,
        LoanRoute.argLoanSelected: widget.loanProductSelected,
        LoanRoute.argIsRemoteLoan: false,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.subtitle1;
    final messageStyle = Theme.of(context).textTheme.bodyText1;

    final btnStyle = Theme.of(context)
        .textTheme
        .button
        ?.copyWith(color: mColorBodyTextGreen);

    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        title: Text(
          S.current.notice,
          style: titleStyle,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.current.confirmBeforeCreateLoanMessage,
              style: messageStyle,
            ),
            VerticalSpace.init16(),
            AppDefaultCheckboxWidget(
              label: S.current.notShowAgain,
              onChanged: (value) {
                print('>>> value: $value');
              },
            )
          ],
        ),
        actionsOverflowDirection: VerticalDirection.down,
        actions: <Widget>[
          Center(
            child: TextButton(
              onPressed: () => _handleAccept(),
              child: Text(
                S.current.accept,
                style: btnStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
