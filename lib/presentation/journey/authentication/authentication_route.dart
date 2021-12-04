import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:flutter_configuration_module/route/route_define.dart';
import 'package:p2p_borrower/domain/usecases/authentication_usecase.dart';
import 'package:p2p_borrower/presentation/journey/authentication/forgot_password/forgot_password_screen.dart';
import 'package:p2p_borrower/presentation/journey/authentication/input_phone/input_phone_screen.dart';
import 'package:p2p_borrower/presentation/journey/authentication/reference_phone/cubit/reference_phone_cubit.dart';
import 'package:p2p_borrower/presentation/journey/authentication/sign_up/cubit/sign_up_cubit.dart';
import 'package:p2p_borrower/presentation/journey/authentication/sign_up/sign_up_screen.dart';
import 'package:p2p_borrower/presentation/journey/authentication/verify_otp/otp_cubit/otp_cubit.dart';
import 'package:p2p_borrower/presentation/journey/authentication/verify_otp/verify_otp_screen.dart';
import 'package:p2p_borrower/presentation/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:p2p_borrower/presentation/cubits/validator_cubit/validator_cubit.dart';

import 'forgot_password/cubit/forgot_password_cubit.dart';
import 'input_phone/cubit/input_phone_cubit.dart';
import 'reference_phone/reference_phone_screen.dart';
import 'sign_in/cubit/sign_in_cubit.dart';
import 'sign_in/sign_in_screen.dart';

class AuthenticationRoute extends RouteDefine {
  /// PHONE INPUT
  static const inputPhoneID = 'input-phone';
  static const idWithParam = 'login-with-param';

  /// VERIFY OTP
  static const verifyOtpID = 'verify-otp';
  static const verifyTypeArg = 'verify-type-arg';

  /// SIGN UP
  static const signUpID = 'sign-up';

  /// REFERENCE PHONE
  static const referencePhoneID = 'reference-phone';

  /// SIGN IN
  static const signInID = 'sign-in';

  /// FORGOT PASSWORD
  static const forgotPasswordID = 'forgot-password';

  /// Arguments
  static const phoneArg = 'phone-arg';
  static const verifyCodeArg = 'verify-code-arg';
  static const userArg = 'user';

  @override
  List<Path> initRoute(Object? arguments) {
    Map<String, dynamic>? args;

    if (arguments != null) {
      args = arguments as Map<String, dynamic>;
    }

    return [
      Path(
          name: inputPhoneID,
          builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                      create: (context) => getIt.get<InputPhoneCubit>()),
                  BlocProvider(create: (context) => ValidatorCubit()),
                ],
                child: InputPhoneScreen(),
              )),
      Path(
        name: verifyOtpID,
        builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                  value: getIt.get<OtpCubit>()
                    ..sendOtp(
                        phone: args![phoneArg],
                        verificationType: args[verifyTypeArg])),
              BlocProvider(create: (context) => ValidatorCubit()),
            ],
            child: VerifyOtpScreen(
              typeOTP: args[verifyTypeArg],
            )),
      ),
      Path(
          name: signUpID,
          builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                      create: (context) => ValidatorCubit(fieldsTotal: 2)),
                  BlocProvider(create: (context) => getIt.get<SignUpCubit>()),
                  BlocProvider(
                      create: (context) => SignInCubit(
                          authenticationUseCase:
                              getIt.get<AuthenticationUseCase>(),
                          authenticationCubit:
                              BlocProvider.of<AuthenticationCubit>(context)))
                ],
                child: SignUpScreen(
                  phone: args![phoneArg],
                  verifiedCode: args[verifyCodeArg],
                ),
              )),
      Path(
          name: referencePhoneID,
          builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => ReferencePhoneCubit(
                      authenticationUseCase: getIt.get<AuthenticationUseCase>(),
                    ),
                  ),
                  BlocProvider(create: (context) => ValidatorCubit()),
                ],
                child: ReferencePhoneScreen(
                  user: args == null ? null : args[userArg],
                ),
              )),
      Path(
          name: signInID,
          builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => SignInCubit(
                        authenticationUseCase:
                            getIt.get<AuthenticationUseCase>(),
                        authenticationCubit:
                            BlocProvider.of<AuthenticationCubit>(context)),
                  ),
                  BlocProvider(create: (context) => ValidatorCubit()),
                ],
                child: SignInScreen(
                  phone: args![phoneArg],
                ),
              )),
      Path(
          name: forgotPasswordID,
          builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                      create: (context) => ValidatorCubit(fieldsTotal: 2)),
                  BlocProvider(
                      create: (context) => getIt.get<ForgotPasswordCubit>()),
                ],
                child: ForgotPasswordScreen(
                  phone: args![phoneArg],
                  verifiedCode: args[verifyCodeArg],
                ),
              )),
    ];
  }
}
