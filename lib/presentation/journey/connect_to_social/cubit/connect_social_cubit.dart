import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:p2p_borrower/common/exceptions/api_exception.dart';
import 'package:p2p_borrower/common/helpers/social_auth/facebook_helper.dart';
import 'package:p2p_borrower/data/model/response/facebook_info_response.dart';
import 'package:p2p_borrower/data/sources/local/profile_session_pref.dart';
import 'package:p2p_borrower/domain/usecases/authentication_usecase.dart';
import 'package:p2p_borrower/presentation/cubits/loader_cubit/loader_cubit.dart';

part 'connect_social_state.dart';

/// global cubit
/// singleton
class ConnectSocialCubit extends Cubit<ConnectSocialState> {
  ConnectSocialCubit(
      {required this.loaderCubit,
      required this.facebookHelper,
      required this.authenticationUseCase})
      : super(ConnectSocialInitial());

  final AuthenticationUseCase authenticationUseCase;
  final FacebookHelper facebookHelper;
  final LoaderCubit loaderCubit;

  Future fetchData() async {
    emit(ConnectSocialLoading());
    final fbProfile = ProfileSessionPref.getFacebookProfile();
    if (fbProfile != null) {
      emit(ConnectSocialLogged(fbProfile: fbProfile));
    } else {
      emit(ConnectSocialLoggedOut());
    }
  }

  Future connectToFacebook() async {
    loaderCubit.loading();
    try {
      final fbResult = await facebookHelper.login();
      if (fbResult.status == LoginStatus.success) {
        final fbProfile = await authenticationUseCase
            .loginFacebook(fbResult.accessToken!.token);

        if (fbProfile == null) {
          // call login fb api failed
          loaderCubit.failure(messages: [SConfig.current.unKnowError]);
        } else {
          // success
          loaderCubit.loaded();
          emit(ConnectSocialLogged(fbProfile: fbProfile));
        }
      } else {
        loaderCubit.failure(messages: [SConfig.current.unKnowError]);
      }
    } on FacebookException catch (error) {
      loaderCubit.failure(messages: [error.message]);
    } on ApiException catch (apiError) {
      loaderCubit.failure(messages: [apiError.errorMessage]);
    } catch (e) {
      loaderCubit.failure(messages: [SConfig.current.unKnowError]);
    }
  }

  Future sigOutFacebook() async {
    loaderCubit.loading();
    try {
      await facebookHelper.logOut();
      await ProfileSessionPref.clearFacebookProfile();
      loaderCubit.loaded();
      emit(ConnectSocialLoggedOut());
    } on FacebookException catch (error) {
      loaderCubit.failure(messages: [error.message]);
    } catch (e) {
      loaderCubit.failure(messages: [SConfig.current.unKnowError]);
    }
  }
}
