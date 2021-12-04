/// NOTE: This data is calculated based on year

class AppAlgorithm {
  static double initCharge(num amount) {
    return amount * 3 / 100;
  }

  /// loan manager charge within xMonth months
  /// interestRate = 1.5%
  static double loanManagerCharge(num amount, num xMonth) {
    return amount * 1.5 / 100;
  }

  static double serviceCharge(num amount, num xMonth) {
    return initCharge(amount) + loanManagerCharge(amount, xMonth);
  }

  static double interestRateAmount(
      num amount, double interestRateYear, num xMonth) {
    return (amount * (xMonth + 1) / 2) * interestRateYear / (12 * 100);
  }

  static double totalLoanAndInterestRateAmount(
      num amount, double interestRateYear, num xMonth) {
    return amount + interestRateAmount(amount, interestRateYear, xMonth);
  }

  static double expectedAmount(
      num amount, double interestRateYear, num xMonth) {
    return serviceCharge(amount, xMonth) +
        totalLoanAndInterestRateAmount(amount, interestRateYear, xMonth);
  }
}
