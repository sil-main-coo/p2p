import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_configuration_module/data/source/local/sessions_pref.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/common/exceptions/local_exception.dart';
import 'package:p2p_borrower/data/model/response/sign_in_response.dart';
import 'package:p2p_borrower/data/sources/local/settings_session_prefer.dart';
import 'package:p2p_borrower/domain/usecases/authentication_usecase.dart';
import 'package:p2p_borrower/domain/usecases/notification_usecase.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(
      {required this.authenticationUseCase, required this.notificationUseCase})
      : super(AuthenticationInitial());

  final AuthenticationUseCase authenticationUseCase;
  final NotificationUseCase notificationUseCase;

  void checkAuthentication() {
    emit(AuthenticationLoading());
    final phone = SessionPref.getUserName();

    if (phone == null) {
      // not yet login
      emit(UnAuthenticated());
      return;
    }

    emit(AuthenticatedAndNotSignIn(phone: phone));

    _checkMultiSignInMessage();
  }

  void _checkMultiSignInMessage() async {
    final message = SettingsSessionPref.getMultiSignInMessage();
    if (message != null) {
      emit(AuthenticatedFailed(listDataMessage: [message]));
    }
  }

  Future signedIn(
      {required String accessToken,
      required String refreshToken,
      required String userName,
      required User user,
      bool autoPush = true}) async {
    emit(AuthenticationLoading());

    try {
      await authenticationUseCase.signedIn(
          accessToken: accessToken,
          refreshToken: refreshToken,
          userName: userName,
          user: user);

      emit(AuthenticatedAndSignedIn(
          phone: userName, token: accessToken, user: user, autoPush: autoPush));
    } catch (e) {
      emit(AuthenticatedFailed(listDataMessage: [SConfig.current.unKnowError]));
    }
  }

  Future signedOut() async {
    emit(AuthenticationLoading());
    try {
      await authenticationUseCase.signOut(); // call sign out api
      await notificationUseCase.unSubscribeByDeviceTopic(); // unsubscribe fcm
      emit(UnAuthenticated());
    } on ApiException catch (apiError) {
      emit(SignedOutFailed(listDataMessage: [apiError.errorMessage]));
    } on LocalException catch (localError) {
      emit(SignedOutFailed(listDataMessage: [
        localError.message ?? SConfig.current.deviceError
      ]));
    } catch (e) {
      emit(SignedOutFailed(listDataMessage: [SConfig.current.unKnowError]));
    }
  }
}
