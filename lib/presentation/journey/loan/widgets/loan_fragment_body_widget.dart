import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/data/model/response/loan_products_response.dart';
import 'package:p2p_borrower/presentation/common/components/space_widgets/vertical_space_widget.dart';
import 'package:p2p_borrower/presentation/common/loan_utils/loan_push_to_action_utils.dart';
import 'has_loan/create_new_loan_item.dart';
import 'has_loan/loan_application_item_widget.dart';

class LoanFragmentBodyWidget extends StatelessWidget {
  LoanFragmentBodyWidget(
      {Key? key, required this.loanApplications, required this.loanProducts})
      : super(key: key);

  final List<LoanApplicationResponse> loanApplications;
  final List<LoanProductsResponse> loanProducts;

  // use to handling action of loan. eg: update/confirm interest rate...
  final LoanPushToActionUtils _loanPushToActionUtils = LoanPushToActionUtils();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (index == loanApplications.length) {
              return CreateNewLoanItem(
                createNewLoan: () => _loanPushToActionUtils
                    .pushToCreateLoanDefault(context, loanProducts),
              );
            }

            return LoanApplicationItemWidget(
              item: loanApplications[index],
            );
          },
          separatorBuilder: (_, __) => VerticalSpace.init8(),
          itemCount: loanApplications.length + 1),
    );
  }
}
