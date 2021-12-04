import 'package:p2p_borrower/data/model/request/create_loan_request.dart';
import 'package:p2p_borrower/data/model/request/loan_status_request.dart';
import 'package:p2p_borrower/data/model/response/base_response.dart';
import 'package:p2p_borrower/data/model/response/create_loan_response.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/loan_application_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';
import 'package:p2p_borrower/data/model/response/loan_products_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/validate_attribute_loan.dart';

abstract class LoanRepository {
  Future<List<LoanProductsResponse>?>? fetchLoanTypeProducts();

  Future<LoanMasterDataResponse?>? fetchLoanMasterData();

  Future<CreateLoanResponse?>? createLoan(
      dynamic hiveKeyLoanSimple, CreateLoanRequest request);

  Future<CreateLoanResponse?>? updateLoan(CreateLoanRequest request);

  Future<List<LoanApplicationResponse>?>? getLoanApplicationsByBorrower();

  Future<LoanApplicationDetailResponse?> getADetailLoan(bool isRemote,
      {dynamic simpleKey, int? loanID});

  Future setALoanInfoToLocal(LoanApplicationResponse simpleLoan,
      LoanApplicationDetailResponse detailLoan, bool isNewLoan);

  Future removeLoan(bool isRemote, LoanApplicationResponse loanLocalResponse);

  Future removeLocalLoanByHiveKey(dynamic simpleKey);

  Future<List<ValidateAttribute>?> getValidateAttributeLoan(int loanID);

  Future<BaseResponse?>? signLoanContract(LoanStatusRequest request);
}
