import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/common/exceptions/local_exception.dart';
import 'package:p2p_borrower/data/model/request/create_loan_request.dart';
import 'package:p2p_borrower/data/model/request/loan_status_request.dart';
import 'package:p2p_borrower/data/model/response/base_response.dart';
import 'package:p2p_borrower/data/model/response/create_loan_response.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/loan_application_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';

import 'package:p2p_borrower/data/model/response/loan_products_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/validate_attribute_loan.dart';
import 'package:p2p_borrower/data/sources/local/loan_application_local_source.dart';
import 'package:p2p_borrower/data/sources/local/loan_master_data_local_source.dart';
import 'package:p2p_borrower/data/sources/local/profile_session_pref.dart';
import 'package:p2p_borrower/data/sources/remote/loan_remote_source.dart';
import 'package:p2p_borrower/domain/repositories/loan_repository.dart';

class LoanRepoImplement implements LoanRepository {
  final LoanRemoteSource loanRemoteSource;
  final LoanMasterDataLocalSource loanLocalSource;
  final LoanApplicationLocalSource loanApplicationLocalSource;

  LoanRepoImplement(
      {required this.loanRemoteSource,
      required this.loanLocalSource,
      required this.loanApplicationLocalSource});

  @override
  Future<List<LoanProductsResponse>?>? fetchLoanTypeProducts() async {
    try {
      List<LoanProductsResponse>? loanProducts;
      //     = loanLocalSource.getLoanTypeProducts();

      // if (loanProducts == null) {
      loanProducts = await loanRemoteSource.fetchLoanTypeProducts();
      if (loanProducts != null && loanProducts.isNotEmpty) {
        loanLocalSource.saveLoanTypeProducts(loanProducts); // save to hive
        // }
      }

      return loanProducts;
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future<LoanMasterDataResponse?>? fetchLoanMasterData() async {
    try {
      return await loanRemoteSource.fetchLoanMasterData();
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future<CreateLoanResponse?>? createLoan(
      dynamic hiveKeyLoanSimple, CreateLoanRequest request) async {
    try {
      final loanCreated = await loanRemoteSource.createLoan(request);
      if (loanCreated != null && hiveKeyLoanSimple != null) {
        await removeLocalLoanByHiveKey(hiveKeyLoanSimple);
      }

      return loanCreated;
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future<List<LoanApplicationResponse>?>?
      getLoanApplicationsByBorrower() async {
    List<LoanApplicationResponse>? results = [];

    try {
      final user = ProfileSessionPref.getProfile();
      if (user != null) {
        final remoteLoans = await loanRemoteSource
            .getLoanApplicationsByBorrower(user.accountId!);
        final localLoans = await loanApplicationLocalSource.getSimpleLoans();

        results.addAll(localLoans.reversed.toList());
        if (remoteLoans != null) results.addAll(remoteLoans.reversed.toList());
        return results;
      }
      return [];
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future<LoanApplicationDetailResponse?> getADetailLoan(bool isRemote,
      {dynamic simpleKey, int? loanID}) async {
    try {
      if (isRemote) {
        return (await loanRemoteSource.getLoanApplicationDetail(loanID!))!;
      }

      return loanApplicationLocalSource.getADetailLoan(simpleKey);
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } on LocalException catch (e) {
      throw e;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future<dynamic> setALoanInfoToLocal(LoanApplicationResponse simpleLoan,
      LoanApplicationDetailResponse detailLoan, bool isNewLoan) async {
    if (isNewLoan) {
      final localSimpleLoanKey =
          await loanApplicationLocalSource.addALoanSimple(simpleLoan);
      await loanApplicationLocalSource.addADetailLoan(
          simpleLoan.key, detailLoan);
      return localSimpleLoanKey;
    } else {
      await simpleLoan.save();
      await loanApplicationLocalSource.addADetailLoan(
          simpleLoan.key, detailLoan);
      return simpleLoan.key;
    }
  }

  @override
  Future removeLoan(bool isRemote, LoanApplicationResponse item) async {
    if (isRemote) {
      // todo call remove loan by api
    } else {
      // remove a loan in local
      await item.delete();
      await loanApplicationLocalSource.removeADetailLoan(item.key);
    }
  }

  @override
  Future removeLocalLoanByHiveKey(simpleKey) async {
    // remove a loan in local
    await loanApplicationLocalSource.removeALoanSimpleByKey(simpleKey);
    await loanApplicationLocalSource.removeADetailLoan(simpleKey);
  }

  @override
  Future<CreateLoanResponse?>? updateLoan(CreateLoanRequest request) async {
    try {
      return await loanRemoteSource.updateLoan(request);
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Unexpected Exception $e');
    }
  }

  @override
  Future<List<ValidateAttribute>?> getValidateAttributeLoan(int loanID) async {
    try {
      return await loanRemoteSource.getValidateAttributeLoan(loanID);
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    }
  }

  @override
  Future<BaseResponse?>? signLoanContract(LoanStatusRequest request) async {
    try {
      return await loanRemoteSource.updateLoanStatus(request);
    } on DioError catch (dioError) {
      throw ApiException(exception: dioError);
    }
  }
}
