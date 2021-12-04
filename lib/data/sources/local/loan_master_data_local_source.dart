import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:p2p_borrower/common/exceptions/local_exception.dart';
import 'package:p2p_borrower/common/hive/hive_constants.dart';
import 'package:p2p_borrower/data/model/response/loan_products_response.dart';

class LoanMasterDataLocalSource {
  final box = Hive.lazyBox(HiveMasterLoanDataConstants.boxName);

  void saveLoanTypeProducts(List<LoanProductsResponse> data) {
    try {
      box.put(HiveMasterLoanDataConstants.loanProductsKey, data);
    } catch (e) {
      throw LocalException(message: "Failure when add Hive");
    }
  }

  Future<List<LoanProductsResponse>?> getLoanTypeProducts() async {
    try {
      final data = await box.get(HiveMasterLoanDataConstants.loanProductsKey);
      if (data != null) {
        return List<LoanProductsResponse>.from(data);
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      throw LocalException(message: "Failure when get Hive");
    }
  }
}
