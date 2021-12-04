import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:p2p_borrower/common/constants/loan_application_status_constants.dart';
import 'package:p2p_borrower/common/hive/hive_constants.dart';
import 'package:p2p_borrower/common/utils/app_algorithm.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/common/extensions/app_string_extension.dart';
import 'package:p2p_borrower/common/extensions/app_num_extension.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';

import 'loan_products_response.dart';
import 'package:flutter_configuration_module/utility/extentions/date_time_extensions.dart';

part 'loan_application_response.g.dart';

@HiveType(typeId: HiveLoanSimpleConstants.loanSimpleResponse)
class LoanApplicationResponse extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? amountUnit;

  @HiveField(2)
  String? loanProduct;

  @HiveField(3)
  int? loanDuration;

  @HiveField(4)
  String? durationUnit;

  @HiveField(5)
  String? status;

  @HiveField(6)
  int? loanAmount;

  @HiveField(7)
  int? raisedAmount;

  @HiveField(8)
  int? debtAmount;

  @HiveField(9)
  String? statusDisplay;

  @HiveField(10)
  double? interestRate;

  @HiveField(11)
  double? serviceFees;

  @HiveField(12)
  String? phone;

  @HiveField(13)
  int? createDate;

  @HiveField(14)
  String? icon;

  @HiveField(15)
  String? iconPath;

  @HiveField(16)
  int? iconLastModifiedDate;

  @HiveField(17)
  double? expectedTotalPayment;

  @HiveField(18)
  int? expectedTotalPaymentActual;

  @HiveField(19)
  int? serviceFeesActual;

  @HiveField(20)
  int? loanAmountActual;

  LoanApplicationResponse.copy(LoanApplicationResponse? model) {
    if (model != null) {
      this.id = model.id;
      this.amountUnit = model.amountUnit;
      this.loanProduct = model.loanProduct;
      this.loanDuration = model.loanDuration;
      this.durationUnit = model.durationUnit;
      this.status = model.status;
      this.loanAmount = model.loanAmount;
      this.loanAmountActual = model.loanAmountActual;
      this.raisedAmount = model.raisedAmount;
      this.debtAmount = model.debtAmount;
      this.statusDisplay = model.statusDisplay;
      this.interestRate = model.interestRate;
      this.serviceFees = model.serviceFees;
      this.phone = model.phone;
      this.createDate = model.createDate;
      this.createDate = model.createDate;
      this.iconPath = model.iconPath;
      this.iconLastModifiedDate = model.iconLastModifiedDate;
      this.expectedTotalPayment = model.expectedTotalPayment;
      this.expectedTotalPaymentActual = model.expectedTotalPaymentActual;
      this.serviceFeesActual = model.serviceFeesActual;
      this.loanAmountActual = model.loanAmountActual;
    }
  }

  void setParams(LoanApplicationResponse? model) {
    if (model != null) {
      this.id = model.id;
      this.amountUnit = model.amountUnit;
      this.loanProduct = model.loanProduct;
      this.loanDuration = model.loanDuration;
      this.durationUnit = model.durationUnit;
      this.status = model.status;
      this.loanAmount = model.loanAmount;
      this.raisedAmount = model.raisedAmount;
      this.debtAmount = model.debtAmount;
      this.statusDisplay = model.statusDisplay;
      this.interestRate = model.interestRate;
      this.serviceFees = model.serviceFees;
      this.phone = model.phone;
      this.createDate = model.createDate;
      this.createDate = model.createDate;
      this.iconPath = model.iconPath;
      this.iconLastModifiedDate = model.iconLastModifiedDate;
      this.expectedTotalPayment = model.expectedTotalPayment;
      this.expectedTotalPaymentActual = model.expectedTotalPaymentActual;
      this.serviceFeesActual = model.serviceFeesActual;
      this.loanAmountActual = model.loanAmountActual;
    }
  }

  DateTime? get createDateTime => createDate == null
      ? null
      : DateTime.fromMillisecondsSinceEpoch(createDate! * 1000);

  String? get createDateTimeFormatted {
    return createDateTime!.toStringDefault;
  }

  String? get createDateTimeFormattedWithHourMinute {
    return createDateTime!.toStringDefaultWithHourMinute;
  }

  String get expectedTotalPaymentFormatted {
    return '${expectedTotalPaymentActual!.toDefaultFormatNumberString}${S.current.money_currency}';
  }

  String get serviceFeesFormatted {
    return '${serviceFeesActual!.toDefaultFormatNumberString}${S.current.money_currency}';
  }

  String get raisedAmountFormatted {
    return '${raisedAmount!.toDefaultFormatNumberString}${S.current.money_currency}';
  }

  String get raisedAmountFormattedWithoutCurrency {
    return '${raisedAmount!.toDefaultFormatNumberString}';
  }

  String get numberDayRaised {
    if (createDateTime != null)
      return '${createDateTime?.differenceDay(input: DateTime.now())} ${S.current.day.toLowerCase()}';
    return '';
  }

  String get raisedDayLeftFormatted {
    if (createDateTime != null)
      return '${7 - DateTime.now().differenceDay(input: createDateTime!)} ${S.current.day.toLowerCase()}';
    return '';
  }

  String get expectedInterestRateStringFormatted =>
      '$interestRate%/${S.current.year.toLowerCase()}';

  bool get isSaveLocal => status == LoanApplicationStatus.Draft;

  bool get isRaisedEnough => this.raisedAmount == this.loanAmountActual;

  bool get isEnoughToDisbursement =>
      this.raisedAmount != null &&
      loanAmountActual != null &&
      this.raisedAmount! >= loanAmountActual! / 3;

  void fromLoanProduct(LoanProductsResponse product) {
    // if loan amount not yet initial or great then max amount
    this.loanProduct = product.name;
    this.amountUnit = product.amountUnit;
    this.durationUnit = product.durationUnit;
    this.status = LoanApplicationStatus.Draft;
    this.raisedAmount = 0;
    this.debtAmount = 0;
    this.icon = product.icon;
    this.iconPath = product.iconPath;

    if (loanAmount == null ||
        (loanAmount != null && loanAmount! > product.maximumAmount!)) {
      setLoanAmountActualFromEmulatorValue(product.minimumAmount!);
    }
    if (loanDuration == null ||
        (loanDuration != null && loanAmount! > product.maximumAmount!)) {
      this.loanDuration = product.minimumDuration!;
    }

    setExpectedAmountCharge();
    setServiceFees();
  }

  void setIcon(String? icon, String? iconPath) {
    this.icon = icon;
    this.iconPath = iconPath;
  }

  void setLoanAmountActualFromEmulatorValue(int? loanEmulator) {
    if (loanEmulator != null) {
      this.loanAmount = loanEmulator;
      loanAmountActual = this.loanAmount!.toActualNumberWithinUnit(amountUnit!);
    }
  }

  void setLoanAmountEmulatorFromActualValue(int? loanActual) {
    if (loanActual != null) {
      this.loanAmountActual = loanActual;
      this.loanAmount =
          this.loanAmountActual?.toEmulatorNumberWithinUnit(amountUnit);
    }
  }

  void setExpectedAmountCharge() {
    if (interestRate != null) {
      if (amountUnit != null) {
        expectedTotalPayment = AppAlgorithm.expectedAmount(
            loanAmount!, interestRate!, loanDuration!);
        expectedTotalPaymentActual =
            expectedTotalPayment!.toActualNumberWithinUnit(amountUnit!);
      } else {
        expectedTotalPaymentActual = AppAlgorithm.expectedAmount(
                loanAmountActual!, interestRate!, loanDuration!)
            .toInt();
      }
    }
  }

  void setServiceFees() {
    if (amountUnit != null) {
      serviceFees = AppAlgorithm.serviceCharge(loanAmount!, loanDuration!);
      serviceFeesActual = serviceFees!.toActualNumberWithinUnit(amountUnit!);
    } else {
      serviceFeesActual =
          AppAlgorithm.serviceCharge(loanAmountActual!, loanDuration!).toInt();
    }
  }

  String get monthlyInstallment =>
      (loanAmountActual! / loanDuration!).round().toDefaultFormatNumberString +
      S.current.money_currency;

  String get durationUnitTranslated => durationUnit!.translate.toLowerCase();

  String get loanAmountActualFormatted =>
      '${loanAmountActual!.toDefaultFormatNumberString}${S.current.money_currency}';

  String get statusText {
    if (statusDisplay != null &&
        statusDisplay!.isNotEmpty &&
        this.isRaisedEnough) {
      return statusDisplay!;
    }

    switch (status) {
      case LoanApplicationStatus.Submitted:
        return S.current.submitted;
      case LoanApplicationStatus.Draft:
        return S.current.incomplete;
      case LoanApplicationStatus.UpdateRequired:
        return S.current.updateRequired;
      case LoanApplicationStatus.MoreInfoRequired:
        return S.current.moreInfoRequired;
      case LoanApplicationStatus.Reject:
        return S.current.reject;
      case LoanApplicationStatus.Cancel:
        return S.current.cancelStatus;
      case LoanApplicationStatus.InterestRateConfirm:
        return S.current.interestRateConfirmStatus;
      case LoanApplicationStatus.OnMarket:
        return S.current.onMarket;
      case LoanApplicationStatus.FundRaised:
        if (this.isRaisedEnough) {
          return S.current.fundRaisedEnough;
        }
        return S.current.fundRaised;
      case LoanApplicationStatus.FundOvertime:
        return S.current.fundOvertime;
      case LoanApplicationStatus.DisburmentPending:
        return S.current.disburmentPending;
      case LoanApplicationStatus.OnLoan:
        return S.current.onLoan;
      case LoanApplicationStatus.Updated:
        return S.current.updatedInfo;
      default:
        return S.current.incomplete;
    }
  }

  Color get statusColor {
    switch (status) {
      case LoanApplicationStatus.Submitted:
        return mColorDescription;
      case LoanApplicationStatus.Draft:
      case LoanApplicationStatus.UpdateRequired:
      case LoanApplicationStatus.MoreInfoRequired:
        return Colors.orange;
      case LoanApplicationStatus.Reject:
      case LoanApplicationStatus.Cancel:
        return mColorBad;
      case LoanApplicationStatus.InterestRateConfirm:
      case LoanApplicationStatus.OnMarket:
      case LoanApplicationStatus.FundRaised:
      case LoanApplicationStatus.DisburmentPending:
      case LoanApplicationStatus.OnLoan:
        return mColorBodyTextGreen;
      case LoanApplicationStatus.FundOvertime:
        if (isEnoughToDisbursement) return mColorBodyTextGreen;
        return mColorBad;
      default:
        return mColorBodyText;
    }
  }

  LoanApplicationResponse(
      {this.id,
      this.expectedTotalPayment,
      this.iconPath,
      this.icon,
      this.iconLastModifiedDate,
      this.loanProduct,
      this.loanDuration,
      this.durationUnit,
      this.status,
      this.loanAmountActual,
      this.loanAmount,
      this.raisedAmount,
      this.debtAmount,
      this.statusDisplay,
      this.interestRate,
      this.serviceFees,
      this.phone,
      this.createDate});

  LoanApplicationResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amountUnit = json['amountUnit'];
    loanProduct = json['loanProduct'];
    loanDuration = json['loanDuration'];
    durationUnit = json['durationUnit'];
    status = json['status'];
    setLoanAmountEmulatorFromActualValue(json['loanAmount']);
    raisedAmount = json['raisedAmount'];
    debtAmount = json['debtAmount'];
    statusDisplay = json['statusDisplay'];
    interestRate = double.tryParse(json['interestRate'].toString());
    serviceFeesActual = json['serviceFees'];
    phone = json['phone'];
    createDate = json['createDate'];
    icon = json['icon'];
    iconPath = json['iconPath'];
    iconLastModifiedDate = json['iconLastModifiedDate'];

    setExpectedAmountCharge();
    setServiceFees();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amountUnit'] = this.amountUnit;
    data['loanProduct'] = this.loanProduct;
    data['expectedTotalPayment'] = this.expectedTotalPaymentActual;
    data['loanDuration'] = this.loanDuration;
    data['durationUnit'] = this.durationUnit;
    data['status'] = this.status;
    data['loanAmount'] = this.loanAmountActual;
    data['raisedAmount'] = this.raisedAmount;
    data['debtAmount'] = this.debtAmount;
    data['statusDisplay'] = this.statusDisplay;
    data['interestRate'] = this.interestRate;
    data['serviceFees'] = this.serviceFeesActual;
    data['phone'] = this.phone;
    data['createDate'] = this.createDate;
    data['icon'] = this.icon;
    data['iconPath'] = this.iconPath;
    data['iconLastModifiedDate'] = this.iconLastModifiedDate;
    return data;
  }
}
