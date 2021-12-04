import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:p2p_borrower/common/helpers/firebase/fcm_helper.dart';
import 'package:p2p_borrower/common/helpers/image_picker/image_picker_helper.dart';
import 'package:p2p_borrower/common/helpers/local_notify/local_notify_helper.dart';
import 'package:p2p_borrower/data/sources/local/device_local_source.dart';
import 'package:p2p_borrower/domain/repositories/account_repository.dart';
import 'package:p2p_borrower/domain/repositories/device_repository.dart';
import 'package:p2p_borrower/domain/repositories/loan_repository.dart';
import 'package:p2p_borrower/domain/repositories/otp_repository.dart';
import 'package:p2p_borrower/domain/repositories/payment_repository.dart';
import 'package:p2p_borrower/domain/usecases/authentication_usecase.dart';
import 'package:p2p_borrower/domain/usecases/create_loan_usecase.dart';
import 'package:p2p_borrower/domain/usecases/loan_usecase.dart';
import 'package:p2p_borrower/domain/usecases/notification_usecase.dart';
import 'package:p2p_borrower/domain/usecases/picture_usecase.dart';
import 'package:p2p_borrower/domain/usecases/payment_usecase.dart';
import 'package:p2p_borrower/domain/usecases/update_loan_usecase.dart';

class UseCaseModule extends DIModule {
  @override
  provides() async {
    getIt.registerFactory(() => AuthenticationUseCase(
        deviceRepository: getIt<DeviceRepository>(),
        otpRepository: getIt<OTPRepository>(),
        accountRepository: getIt<AccountRepository>()));
    getIt.registerFactory(() => NotificationUseCase(
          fcmHelper: getIt.get<FirebaseMessageHelper>(),
          localNotifyHelper: getIt.get<LocalNotifyHelper>(),
          deviceLocalSource: getIt.get<DeviceLocalSource>(),
        ));
    getIt.registerFactory(() => CreateLoanUseCase(
          loanRepository: getIt<LoanRepository>(),
          paymentRepository: getIt<PaymentRepository>(),
        ));
    getIt.registerFactory(() => PaymentUseCase(
          paymentRepository: getIt<PaymentRepository>(),
        ));
    getIt.registerFactory(() => PictureUseCase(
          imagePickerHelper: getIt<ImagePickerHelper>(),
        ));
    getIt.registerFactory(() => LoanUseCase(
          loanRepository: getIt<LoanRepository>(),
        ));
    getIt.registerFactory(() => UpdateLoanUseCase(
          loanRepository: getIt<LoanRepository>(),
        ));
  }
}
