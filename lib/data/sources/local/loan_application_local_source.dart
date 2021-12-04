import 'package:flutter/foundation.dart';
import 'package:p2p_borrower/common/exceptions/local_exception.dart';
import 'package:p2p_borrower/common/hive/hive.dart';
import 'package:p2p_borrower/common/hive/hive_constants.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/loan_application_detail_response.dart';

class LoanApplicationLocalSource {
  /// SIMPLE LOAN
  Future<int> addALoanSimple(LoanApplicationResponse loanLocalResponse) async {
    try {
      final _simpleLoanBox =
          await HiveSetup.getLazyBox(HiveLoanSimpleConstants.boxName());
      return await _simpleLoanBox.add(loanLocalResponse);
    } catch (e) {
      print(e);
      throw LocalException(
          message:
              "Failure when addALoanSimple Hive in LoanApplicationLocalSource");
    }
  }

  Future removeALoanSimpleByKey(dynamic key) async {
    try {
      final _simpleLoanBox =
      await HiveSetup.getLazyBox(HiveLoanSimpleConstants.boxName());
      await _simpleLoanBox.delete(key);
    } catch (e) {
      print(e);
      throw LocalException(
          message:
          "Failure when addALoanSimple Hive in LoanApplicationLocalSource");
    }
  }

  Future<List<LoanApplicationResponse>> getSimpleLoans() async {
    List<LoanApplicationResponse> results = [];

    try {
      final _simpleLoanBox =
          await HiveSetup.getLazyBox(HiveLoanSimpleConstants.boxName());
      for (int i = 0; i < _simpleLoanBox.length; i++) {
        results.add(await _simpleLoanBox.getAt(i));
      }

      return results;
    } catch (e) {
      debugPrint(e.toString());
      throw LocalException(
          message:
              "Failure when getSimpleLoans Hive in LoanApplicationLocalSource");
    }
  }

  /// DETAIL LOAN
  Future addADetailLoan(
      dynamic simpleKey, LoanApplicationDetailResponse detailResponse) async {
    try {
      final _detailLoanBox =
          await HiveSetup.getLazyBox(HiveLoanDetailConstants.boxName());

      await _detailLoanBox.put(simpleKey, detailResponse);
    } catch (e) {
      throw LocalException(
          message:
              "Failure when addADetailLoan Hive in LoanApplicationLocalSource");
    }
  }

  Future<LoanApplicationDetailResponse> getADetailLoan(
    dynamic simpleKey,
  ) async {
    try {
      final _detailLoanBox =
          await HiveSetup.getLazyBox(HiveLoanDetailConstants.boxName());
      return await _detailLoanBox.get(simpleKey);
    } catch (e) {
      print(e);
      throw LocalException(
          message:
              "Failure when getADetailLoan Hive in LoanApplicationLocalSource");
    }
  }

  Future removeADetailLoan(dynamic simpleKey) async {
    try {
      final _detailLoanBox =
          await HiveSetup.getLazyBox(HiveLoanDetailConstants.boxName());
      return await _detailLoanBox.delete(simpleKey);
    } catch (e) {
      throw LocalException(
          message:
              "Failure when removeADetailLoan Hive in LoanApplicationLocalSource");
    }
  }

  Future<List<LoanApplicationDetailResponse>> getDetailLoans() async {
    List<LoanApplicationDetailResponse> results = [];

    try {
      final _detailLoanBox =
          await HiveSetup.getLazyBox(HiveLoanDetailConstants.boxName());
      for (int i = 0; i < _detailLoanBox.length; i++) {
        results.add(await _detailLoanBox.getAt(i));
      }

      return results;
    } catch (e) {
      debugPrint(e.toString());
      throw LocalException(
          message:
              "Failure when getDetailLoans Hive in LoanApplicationLocalSource");
    }
  }
}
