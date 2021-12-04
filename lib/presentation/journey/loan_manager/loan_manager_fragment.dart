import 'package:flutter/material.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_step_action.dart';

import 'widgets/loan_manager_empty_layout.dart';
import 'widgets/loan_manager_layout.dart';

class LoanManagerFragment extends StatelessWidget {
  const LoanManagerFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isEmpty = false;

    return Scaffold(
      appBar: AppbarAction(
        titleText: S.current.loansManager,
      ),
      body: isEmpty ? LoanManagerEmptyLayout() : LoanManagerLayout(),
    );
  }
}
