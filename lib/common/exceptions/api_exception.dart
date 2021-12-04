import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:flutter_configuration_module/network/interceptor/token_interceptor.dart';
import 'package:p2p_borrower/common/exceptions/response_error.dart';

class ApiException {
  String? errorCode;
  String errorMessage = "";
  DioError? exception;

  ApiException({this.exception}) {
    switch (exception?.type) {
      case DioErrorType.response:
        {

          dynamic errorBody = exception?.response?.data ?? "";
          try {
            // try to parse to response error
            ResponseError responseError = ResponseError.fromJson(errorBody);
            errorMessage = responseError.message;
            errorCode = responseError.errorCode;

            // map 401 to meaningful messages
            if (TokenInterceptor.unauthorizedTokenCodes
                .contains(responseError.statusCode)) {
              errorMessage = SConfig.current.invalidCredentials;
              return;
            }

            // map 500 to meaningful msg
            if (responseError.statusCode >= 400) {
              errorMessage = SConfig.current.systemError;
              return;
            }

          } catch (e) {
            errorMessage = e.toString();

            // Try to get Dio internal error which might due to service not available
            if (exception?.error != null) {
              errorMessage = exception?.error?.toString() ?? "";
            }

            if (exception?.response?.statusMessage != null &&
                exception?.response?.statusMessage?.isNotEmpty == true) {
              errorMessage = exception?.response?.statusMessage ?? "";
            }
          }
        }
        break;
      default:
        {
          switch (exception?.type) {
            case DioErrorType.connectTimeout:
            case DioErrorType.receiveTimeout:
            case DioErrorType.sendTimeout:
              {
                errorMessage = SConfig.current.connectionTimedOut;
              }
              break;
            default:
              {
                if (exception?.error is SocketException) {
                  errorMessage = SConfig.current.connectionProblem;
                } else if (exception?.error is HttpException) {
                  errorMessage = SConfig.current.connectionProblem;
                }else{
                  errorMessage = SConfig.current.systemError;
                }
              }
          }
        }
    }
  }
}
