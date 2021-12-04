import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:flutter_configuration_module/environment/build_config.dart';
import 'package:flutter_configuration_module/network/interceptor/auth_interceptor.dart';
import 'package:flutter_configuration_module/network/interceptor/token_interceptor.dart';
import 'package:p2p_borrower/data/sources/remote/account_remote_source.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:p2p_borrower/data/sources/remote/loan_remote_source.dart';
import 'package:p2p_borrower/data/sources/remote/otp_remote_source.dart';
import 'package:p2p_borrower/data/sources/remote/payment_remote_source.dart';

class ApiModule extends DIModule {
  @override
  provides() async {
    final dio = await setup();
    getIt.registerSingleton(dio);
    // register api
    getIt.registerFactory(
        () => AccountRemoteSource(dio, baseUrl: dio.options.baseUrl));
    getIt.registerFactory(
        () => OTPRemoteSource(dio, baseUrl: dio.options.baseUrl));
    getIt.registerFactory(
        () => LoanRemoteSource(dio, baseUrl: dio.options.baseUrl));
    getIt.registerFactory(
        () => PaymentRemoteSource(dio, baseUrl: dio.options.baseUrl));
  }

  static FutureOr<Dio> setup() async {
    final options = BaseOptions(
      connectTimeout: BuildConfig.get()?.connectTimeout,
      receiveTimeout: BuildConfig.get()?.receiveTimeout,
      responseType: ResponseType.json,
      sendTimeout: 5000,
      validateStatus: (status) {
        return true;
      },
      baseUrl: BuildConfig.get()?.baseUrl ?? "",
    );
    final Dio dio = Dio(options);

    /// Unified add authentication request header
    dio.interceptors.add(AuthInterceptor());

    /// Adapt data (according to your own data structure, you can choose to add it)
    dio.interceptors.add(TokenInterceptor());

    /// Print Log (production mode removal)
    if (BuildConfig.get()?.flavor != null &&
        BuildConfig.get()?.flavor != Flavor.RELEASE) {
      dio.interceptors.add(
          LogInterceptor(requestBody: true, responseBody: true, error: true));
    }
    return dio;
  }
}
