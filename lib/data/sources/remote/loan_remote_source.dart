import 'package:p2p_borrower/data/model/request/create_loan_request.dart';
import 'package:p2p_borrower/data/model/request/loan_status_request.dart';
import 'package:p2p_borrower/data/model/response/base_response.dart';
import 'package:p2p_borrower/data/model/response/create_loan_response.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/loan_application_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/validate_attribute_loan.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import 'package:p2p_borrower/data/model/response/loan_products_response.dart';

part 'loan_remote_source.g.dart';

@RestApi()
abstract class LoanRemoteSource {
  factory LoanRemoteSource(Dio dio, {String baseUrl}) = _LoanRemoteSource;

  @GET('/borrower/Loan/loan-products')
  Future<List<LoanProductsResponse>?>? fetchLoanTypeProducts();

  @GET('/borrower/Loan/master-data')
  Future<LoanMasterDataResponse?>? fetchLoanMasterData();

  @POST('/borrower/Loan/create-loan-application')
  Future<CreateLoanResponse?>? createLoan(@Body() CreateLoanRequest request);

  @GET('/borrower/Loan/get-loan-applications-by-borrower')
  Future<List<LoanApplicationResponse>?>? getLoanApplicationsByBorrower(
      @Query("id") int uid);

  @GET('/borrower/Loan/get-loan-application-detail')
  Future<LoanApplicationDetailResponse?>? getLoanApplicationDetail(
      @Query("id") int loanID);

  @POST('/borrower/Loan/update-loan-application')
  Future<CreateLoanResponse?>? updateLoan(@Body() CreateLoanRequest request);

  @GET('/mock/get-loan-validate-attributes')
  Future<List<ValidateAttribute>?>? getValidateAttributeLoan(
      @Query("id") int loanID);

  @POST('/mock/update-loan-status')
  Future<BaseResponse?>? updateLoanStatus(@Body() LoanStatusRequest request);
}
