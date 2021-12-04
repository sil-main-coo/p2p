import 'package:p2p_borrower/data/model/request/relative_person_request.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/loan_application_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/profile_loan_detail_response.dart';
import 'package:p2p_borrower/data/model/response/loan_detail/validate_attribute_loan.dart';
import 'package:p2p_borrower/data/model/response/loan_master_data_response.dart';
import 'package:p2p_borrower/presentation/journey/select_address/model/address_selected.dart';

class PersonalInfoStepModel {
  ProfileLoanDetailResponse? profile;
  RelativePersonRequest? relativePerson1;
  RelativePersonRequest? relativePerson2;
  AddressSelected? residentAddress;
  AddressSelected? currentAddress;
  OwnerShipTypeResponse? ownerShipType;
  MaritalStatusResponse? maritalStatus;
  Map<String, ValidateAttribute>? profileValidAttribute;
  Map<String, ValidateAttribute>? addressValidAttribute;
  Map<String, ValidateAttribute>? relativeValidAttribute;

  PersonalInfoStepModel(
      {this.profile,
      this.relativePerson2,
      this.residentAddress,
      this.currentAddress,
      this.ownerShipType,
      this.maritalStatus});

  PersonalInfoStepModel.initial() {
    this.profile = ProfileLoanDetailResponse.initial();
  }

  PersonalInfoStepModel.fromLocalData(
      {required LoanApplicationDetailResponse detailLoan,
      required LoanMasterDataResponse masterDataResponse,
      Map<String, ValidateAttribute>? profileValidAttribute,
      Map<String, ValidateAttribute>? addressValidAttribute,
      Map<String, ValidateAttribute>? relativeValidAttribute}) {
    this.profile = detailLoan.profile;

    this.relativePerson1 = detailLoan.relativePerson1;
    this.relativePerson2 = detailLoan.relativePerson2;

    if (detailLoan.residentAddress != null)
      this.residentAddress = AddressSelected.fromAddressRequest(
          masterDataResponse.addresses!, detailLoan.residentAddress!);

    if (detailLoan.currentAddress != null)
      this.currentAddress = AddressSelected.fromAddressRequest(
          masterDataResponse.addresses!, detailLoan.currentAddress!);

    if (detailLoan.ownedType != null)
      this.ownerShipType = masterDataResponse.ownerShipTypes!
          .firstWhere((element) => element.name == detailLoan.ownedType);

    if (detailLoan.maritalStatusId != null)
      this.maritalStatus = masterDataResponse.maritalStatuses!
          .firstWhere((element) => element.id == detailLoan.maritalStatusId);

    // validate attributes
    if (profileValidAttribute != null)
      this.profileValidAttribute = profileValidAttribute;
    if (addressValidAttribute != null)
      this.addressValidAttribute = addressValidAttribute;
    if (relativeValidAttribute != null)
      this.relativeValidAttribute = relativeValidAttribute;
  }
}
