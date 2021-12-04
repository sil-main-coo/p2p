import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_configuration_module/data/common/shared_preferences_manager.dart';
import 'package:flutter_configuration_module/data/source/local/sessions_pref.dart';
import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:p2p_borrower/presentation/journey/app_pick/app_pick_route.dart';
import 'package:p2p_borrower/presentation/journey/authentication/authentication_route.dart';
import 'package:p2p_borrower/presentation/journey/home/home_route.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/linking_payment_route.dart';
import 'package:p2p_borrower/presentation/journey/loan/loan_route.dart';
import 'package:p2p_borrower/presentation/journey/onboarding/onboarding_route.dart';
import 'package:p2p_borrower/presentation/journey/select_address/select_address_route.dart';
import 'data/model/response/multi_signin_message_response.dart';
import 'data/sources/local/settings_session_prefer.dart';
import 'presentation/journey/connect_to_social/connect_social_route.dart';
import 'presentation/journey/dev_test/dev_test_route.dart';
import 'presentation/journey/splash/splash_route.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.data}');

  if (!getIt.isRegistered<SharedPreferencesManager>()) {
    getIt.registerSingleton(SharedPreferencesManager());
    await getIt.get<SharedPreferencesManager>().init();
  }

  final response = MultiSignInMessageResponse.fromJson(message.data);
  if (response.loginTime != null && response.loginDeviceId != null) {
    // handling sign out on device
    // and save alert data
    final response = MultiSignInMessageResponse.fromJson(message.data);

    if (response.loginTime != null && response.loginDeviceId != null) {
      await SessionPref.removeTokenUserData();
      SettingsSessionPref.saveMultiSignInMessage(message: response);
    }
  }
}

void generateRoute(
    Map<String?, WidgetBuilder?>? builders, RouteSettings settings) {
  DevTestRoute().build(builders, settings);
  SplashRoute().build(builders, settings);
  OnBoardingRoute().build(builders, settings);
  AuthenticationRoute().build(builders, settings);
  AppPickRoute().build(builders, settings);
  HomeRoute().build(builders, settings);
  LoanRoute().build(builders, settings);
  SelectAddressRoute().build(builders, settings);
  LinkingPaymentRoute().build(builders, settings);
  ConnectSocialRoute().build(builders, settings);
}

MaterialPageRoute? manifest(RouteSettings settings) {
  final Map<String?, WidgetBuilder?>? routeBuilders = <String, WidgetBuilder>{};

  generateRoute(routeBuilders, settings);

  final Widget Function(BuildContext context)? routeBuilder =
      routeBuilders?[settings.name ?? ""];

  return MaterialPageRoute(
      builder: (context) => routeBuilder!(context),
      settings: RouteSettings(name: settings.name));
}
