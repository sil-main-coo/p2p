import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:p2p_borrower/common/helpers/social_auth/facebook_helper.dart';
import 'package:p2p_borrower/domain/repositories/loan_repository.dart';
import 'package:p2p_borrower/domain/usecases/authentication_usecase.dart';
import 'package:p2p_borrower/domain/usecases/create_loan_usecase.dart';
import 'package:p2p_borrower/domain/usecases/home_usecases.dart';
import 'package:p2p_borrower/domain/usecases/loan_usecase.dart';
import 'package:p2p_borrower/domain/usecases/notification_usecase.dart';
import 'package:p2p_borrower/domain/usecases/picture_usecase.dart';
import 'package:p2p_borrower/domain/usecases/payment_usecase.dart';
import 'package:p2p_borrower/domain/usecases/update_loan_usecase.dart';
import 'package:p2p_borrower/presentation/cubits/loader_cubit/loader_cubit.dart';
import 'package:p2p_borrower/presentation/journey/authentication/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:p2p_borrower/presentation/journey/authentication/sign_up/cubit/sign_up_cubit.dart';
import 'package:p2p_borrower/presentation/journey/authentication/verify_otp/otp_cubit/otp_constants.dart';
import 'package:p2p_borrower/presentation/journey/authentication/verify_otp/otp_cubit/otp_cubit.dart';
import 'package:p2p_borrower/presentation/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:p2p_borrower/presentation/cubits/notification_cubit/notification_cubit.dart';
import 'package:p2p_borrower/presentation/cubits/timer_cubit/timer_cubit.dart';
import 'package:p2p_borrower/presentation/cubits/timer_cubit/timer_ticker.dart';
import 'package:p2p_borrower/presentation/journey/authentication/input_phone/cubit/input_phone_cubit.dart';
import 'package:p2p_borrower/presentation/journey/connect_to_social/cubit/connect_social_cubit.dart';
import 'package:p2p_borrower/presentation/journey/home/cubit/home_cubit.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/cubits/linking_payment_cubit/linking_payment_cubit.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/cubits/payment_manager_cubit/payment_manager_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/addition_info_step/cubit/addition_info_step_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/cubits/create_loan_cubit/create_loan_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/id_info_step/cubit/id_info_step_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/loan_info_step/cubit/loan_info_step_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/occupation_info_step/cubit/occupation_info_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/payment_account_step/cubit/payment_account_step_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/create_loan/personal_info_step/cubit/personal_info_step_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/cubits/loan_cubit/loan_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/review_loan/cubit/review_loan_cubit.dart';

class BlocModule extends DIModule {
  @override
  provides() async {
    getIt.registerSingleton<HomeCubit>(HomeCubit(
        homeUseCase: HomeUseCase(loanRepository: getIt.get<LoanRepository>())));
    getIt.registerFactory(() => LoaderCubit());
    getIt.registerSingleton(AuthenticationCubit(
      notificationUseCase: getIt.get<NotificationUseCase>(),
      authenticationUseCase: getIt.get<AuthenticationUseCase>(),
    ));
    getIt.registerFactory<OtpCubit>(() => OtpCubit(
        timerCubit: TimerCubit(
            duration: OTPConstants.OTPIntervalSeconds, ticker: TimerTicker()),
        authenticationUseCase: getIt.get<AuthenticationUseCase>()));
    getIt.registerFactory(() => InputPhoneCubit(
        authenticationUseCase: getIt.get<AuthenticationUseCase>()));
    getIt.registerFactory(() =>
        SignUpCubit(authenticationUseCase: getIt.get<AuthenticationUseCase>()));
    getIt.registerFactory(() => ForgotPasswordCubit(
        authenticationUseCase: getIt.get<AuthenticationUseCase>()));
    getIt.registerLazySingleton(() => NotificationCubit(
        notificationUseCase: getIt.get<NotificationUseCase>()));
    getIt.registerFactory(() =>
        LoanInfoStepCubit(createLoanUseCase: getIt.get<CreateLoanUseCase>()));
    getIt.registerFactory(() => PersonalInfoStepCubit());
    getIt.registerFactory(() => OccupationInfoStepCubit());
    getIt.registerFactory(() => PaymentAccountStepCubit());
    getIt.registerFactory(
        () => IDInfoStepCubit(pictureUseCase: getIt.get<PictureUseCase>()));
    getIt.registerFactory(() =>
        AdditionInfoStepCubit(pictureUseCase: getIt.get<PictureUseCase>()));
    getIt.registerFactory(() => CreateLoanCubit(
          paymentAccountStepCubit: getIt.get<PaymentAccountStepCubit>(),
          idInfoStepCubit: getIt.get<IDInfoStepCubit>(),
          createLoanUseCase: getIt.get<CreateLoanUseCase>(),
          loanInfoStepCubit: getIt.get<LoanInfoStepCubit>(),
          personalInfoStepCubit: getIt.get<PersonalInfoStepCubit>(),
          occupationInfoStepCubit: getIt.get<OccupationInfoStepCubit>(),
          additionInfoStepCubit: getIt.get<AdditionInfoStepCubit>(),
          updateLoanUseCase: getIt.get<UpdateLoanUseCase>(),
        ));
    getIt.registerFactory(() => LinkingPaymentCubit(
          selectPaymentUseCase: getIt.get<PaymentUseCase>(),
        ));
    getIt.registerSingleton(PaymentManagerCubit(
      paymentUseCase: getIt.get<PaymentUseCase>(),
    ));
    getIt.registerFactory(() => ReviewLoanCubit(
          createLoanUseCase: getIt.get<CreateLoanUseCase>(),
          updateLoanUseCase: getIt.get<UpdateLoanUseCase>(),
        ));
    getIt.registerFactory(() => LoanCubit(
          loanUseCase: getIt.get<LoanUseCase>(),
          loaderCubit: getIt.get<LoaderCubit>(),
          updateLoanUseCase: getIt.get<UpdateLoanUseCase>(),
        ));
    getIt.registerSingleton(ConnectSocialCubit(
          authenticationUseCase: getIt.get<AuthenticationUseCase>(),
          facebookHelper: getIt.get<FacebookHelper>(),
          loaderCubit: getIt.get<LoaderCubit>(),
        ));
  }
}
