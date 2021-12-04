import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/failures/normal_failure_widget.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/widgets/create_loan_loading_widget.dart';

import 'cubits/create_loan_cubit/create_loan_cubit.dart';
import 'create_loan_loaded_widget.dart';

class CreateLoanScreen extends StatelessWidget {
  const CreateLoanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<CreateLoanCubit, CreateLoanState>(
      builder: (context, state) {
        if (state is CreateLoanLoaded) {
          return CreateLoanLoadedWidget(state.loanProductSelected);
        }
        if (state is CreateLoanFailure) {
          return NormalFailureWidget(
            message: state.msg,
            label: S.current.tryAgain,
            label1: S.current.goBack,
            onPressed1: () => Navigator.pop(context),
            onPressed: () => BlocProvider.of<CreateLoanCubit>(context)
              ..fetchMasterLoanData(),
          );
        }

        return CreateLoanLoadingWidget();
      },
    ));
  }
}
