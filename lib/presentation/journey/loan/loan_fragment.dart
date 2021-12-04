import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/data/model/response/loan_products_response.dart';

import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/common/components/appbars/appbar_contact_action.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/loading_dialog.dart';
import 'package:p2p_borrower/presentation/common/components/failures/normal_failure_widget.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/cubits/loader_cubit/loader_cubit.dart';
import 'package:p2p_borrower/presentation/journey/home/cubit/home_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/cubits/loan_cubit/loan_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/widgets/loan_fragment_body_widget.dart';
import 'widgets/loan_fragment_body_empty_widget.dart';
import 'widgets/loan_fragment_title_widget.dart';

class LoanFragment extends StatelessWidget {
  final _loadingDialog = AppLoadingDialog();

  void _showFailureDialog(BuildContext context, String error) {
    ActionDialogs.showAction(
        context: context,
        message: error,
        rightLabel: S.current.tryAgain,
        callBackRight: () => Navigator.pop(context));
  }

  void _showSuccessActionAlertDialog(BuildContext context, String msg) {
    ActionDialogs.showAction(
        context: context,
        message: msg,
        rightLabel: S.current.ok.toUpperCase(),
        callBackRight: () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final homeState = BlocProvider.of<HomeCubit>(context).state;
    return Scaffold(
        appBar: AppbarContactAction.home(
          automaticallyImplyLeading: false,
          // centerTitle: true,
        ),
        body: (homeState is HomeLoaded)
            ? _loanBuilder(context, homeState.loanProducts!)
            : SizedBox());
  }

  Widget _loanBuilder(
      BuildContext context, List<LoanProductsResponse> loanProducts) {
    return BlocListener<LoaderCubit, LoaderState>(
      bloc: BlocProvider.of<LoanCubit>(context).loaderCubit,
      listener: (context, state) {
        switch (state.runtimeType) {
          case LoaderLoaded:
            _loadingDialog.popDialog(context: context);
            break;
          case LoaderSuccess:
            _showSuccessActionAlertDialog(
                context, (state as LoaderSuccess).messages[0]);
            break;
          case LoaderFailure:
            _showFailureDialog(context, (state as LoaderFailure).messages[0]);
            break;
          default:
            _loadingDialog.showDefault(context);
        }
      },
      child: BlocBuilder<LoanCubit, LoanState>(
        builder: (context, state) {
          if (state is LoanLoaded) {
            return _loanContentWidget(loanProducts, state.loanApplications);
          }

          if (state is LoanFailure) {
            return NormalFailureWidget(
              message: state.msg,
              label: S.current.tryAgain,
              onPressed: () async => await BlocProvider.of<LoanCubit>(context)
                  .fetchLoanApplications(),
            );
          }

          return _loadingWidget();
        },
      ),
    );
  }

  Widget _loadingWidget() {
    return Center(child: const CircularProgressIndicator());
  }

  Widget _loanContentWidget(List<LoanProductsResponse> loanProducts,
      List<LoanApplicationResponse> loanApplications) {
    bool isEmpty = loanApplications.isEmpty;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          LoanFragmentTitleWidget(
            title: isEmpty
                ? S.current.loanTitleEmpty
                : '${S.current.loanTitleHasData1} ${loanApplications.length} ${S.current.loanTitleHasData2}',
            description: isEmpty
                ? S.current.loanDescriptionEmpty
                : S.current.loanDescriptionHasData,
          ),
          VerticalSpace.init16(),
          isEmpty
              ? LoanFragmentBodyEmptyWidget(
                  loanProducts: loanProducts,
                )
              : LoanFragmentBodyWidget(
                  loanApplications: loanApplications,
                  loanProducts: loanProducts,
                ),
          VerticalSpace.init16(),
        ],
      ),
    );
  }
}
