import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:p2p_borrower/data/repositories/account_repo_impl.dart';
import 'package:p2p_borrower/data/repositories/device_repo_impl.dart';
import 'package:p2p_borrower/data/repositories/loan_repo_impl.dart';
import 'package:p2p_borrower/data/repositories/otp_repo_impl.dart';
import 'package:p2p_borrower/data/repositories/payment_repo_impl.dart';
import 'package:p2p_borrower/data/sources/local/device_local_source.dart';
import 'package:p2p_borrower/data/sources/local/loan_application_local_source.dart';
import 'package:p2p_borrower/data/sources/local/loan_master_data_local_source.dart';
import 'package:p2p_borrower/data/sources/remote/account_remote_source.dart';
import 'package:p2p_borrower/data/sources/remote/loan_remote_source.dart';
import 'package:p2p_borrower/data/sources/remote/otp_remote_source.dart';
import 'package:p2p_borrower/data/sources/remote/payment_remote_source.dart';
import 'package:p2p_borrower/domain/repositories/account_repository.dart';
import 'package:p2p_borrower/domain/repositories/device_repository.dart';
import 'package:p2p_borrower/domain/repositories/loan_repository.dart';
import 'package:p2p_borrower/domain/repositories/otp_repository.dart';
import 'package:p2p_borrower/domain/repositories/payment_repository.dart';

class RepoModule extends DIModule {
  @override
  provides() async {
    getIt.registerFactory<DeviceRepository>(() =>
        DeviceRepoImplement(deviceLocalSource: getIt.get<DeviceLocalSource>()));
    getIt.registerFactory<AccountRepository>(() =>
        AccountRepoImplement(remoteSource: getIt.get<AccountRemoteSource>()));
    getIt.registerFactory<OTPRepository>(
        () => OTPRepoImplement(otpRemoteSource: getIt.get<OTPRemoteSource>()));
    getIt.registerFactory<LoanRepository>(() => LoanRepoImplement(
        loanApplicationLocalSource: getIt.get<LoanApplicationLocalSource>(),
        loanLocalSource: getIt.get<LoanMasterDataLocalSource>(),
        loanRemoteSource: getIt.get<LoanRemoteSource>()));
    getIt.registerFactory<PaymentRepository>(() => PaymentRepoImplement(
        paymentRemoteSource: getIt.get<PaymentRemoteSource>()));
  }
}
