import 'dart:io';
import 'package:hive/hive.dart';
import 'package:p2p_borrower/data/model/request/address_request.dart';
import 'package:p2p_borrower/data/model/request/occupation_info_request.dart';
import 'package:p2p_borrower/data/model/request/relative_person_request.dart';
import 'package:p2p_borrower/data/model/response/loan_application_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/additional_info_loan_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/linked_payment_loan_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/loan_application_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/profile_loan_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_products_response.dart';
import 'package:path_provider/path_provider.dart';

import 'hive_constants.dart';

class HiveSetup {
  static Future init() async {
    Directory? dir = await getExternalStorageDirectory();
    Hive
      ..init(dir!.path)
      ..registerAdapter(LoanProductsResponseAdapter())
      ..registerAdapter(AdditionalInfosAdapter())
      ..registerAdapter(RelativePersonRequestAdapter())
      ..registerAdapter(LinkedPaymentLoanDetailResponseAdapter())
      ..registerAdapter(OccupationInfoStepRequestAdapter())
      ..registerAdapter(ProfileLoanDetailResponseAdapter())
      ..registerAdapter(AddressRequestAdapter())
      ..registerAdapter(AdditionalInfoLoanDetailResponseAdapter())
      ..registerAdapter(LoanApplicationResponseAdapter())
      ..registerAdapter(LoanApplicationDetailResponseAdapter());

    await openSharedBoxes();
  }

  static Future openSharedBoxes() async {
    await Hive.openLazyBox(HiveMasterLoanDataConstants.boxName);
  }

  /// call when signed in to open specific user box
  static Future openUserBoxes() async {
    await Hive.openLazyBox(HiveLoanSimpleConstants.boxName());
    await Hive.openLazyBox(HiveLoanDetailConstants.boxName());
  }

  static Future<LazyBox> getLazyBox(String name) async {
    return Hive.lazyBox(name);
  }
}
