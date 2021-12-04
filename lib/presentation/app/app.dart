import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:flutter_configuration_module/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/manifest.dart';
import 'package:p2p_borrower/presentation/common/styles/style.dart';
import 'package:p2p_borrower/presentation/journey/app_pick/app_pick_route.dart';
import 'package:p2p_borrower/presentation/journey/authentication/authentication_route.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/action_dialogs.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/multi_sign_in_message.dart';
import 'package:p2p_borrower/presentation/journey/dev_test/dev_test_route.dart';
import 'package:p2p_borrower/presentation/journey/onboarding/onboarding_route.dart';
import 'package:p2p_borrower/presentation/journey/splash/splash_route.dart';
import 'global_providers.dart';
import 'package:p2p_borrower/data/model/response/multi_signin_message_response.dart';
import 'package:p2p_borrower/presentation/common/components/dialogs/loading_dialog.dart';
import 'package:p2p_borrower/presentation/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:p2p_borrower/presentation/cubits/notification_cubit/notification_cubit.dart';

class Application extends StatefulWidget {
  final bool isDev;
  final String title;
  final String locale;

  Application({this.isDev = false, required this.title, required this.locale});

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  BuildContext get _globalContext => _navigator.overlay!.context;

  /// ==== INIT LISTENER OF APPLICATION
  @override
  void initState() {
    super.initState();
  }

  /// UnFocus text field
  void _unFocusGlobal() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  Widget _builder(BuildContext context, Widget? child) {
    return MultiBlocListener(
      listeners: [
        /// Notification listener
        BlocListener<NotificationCubit, NotificationState>(
            listener: (context, state) {
          // If have multi sign in notification push to device
          if (state is NotificationAlert &&
              state.listDataMessage![0] is MultiSignInMessageResponse &&
              !MultiSignInMessageDialog.instance.isShow) {
            final response =
                state.listDataMessage![0] as MultiSignInMessageResponse;

            MultiSignInMessageDialog.instance
                .showDefault(context, response, _globalContext);
            return;
          }
        }),

        /// Authentication listener
        BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) {
          if (state is AuthenticatedFailed) {
            getIt.get<AppLoadingDialog>().popDialog();
            // If it is multi sign in message
            // -> show alert dialog
            if (state.listDataMessage![0] is MultiSignInMessageResponse &&
                !MultiSignInMessageDialog.instance.isShow) {
              final response =
                  state.listDataMessage![0] as MultiSignInMessageResponse;

              MultiSignInMessageDialog.instance
                  .showDefault(context, response, _globalContext);
              return;
            }

            // if it is error
            // show dialog
            ActionDialogs.showAction(
                context: _globalContext,
                barrierDismissible: false,
                title: SConfig.current.error,
                message: state.listDataMessage![0],
                rightLabel: S.current.tryAgain,
                callBackRight: () => _navigator.pop(context));
            return;
          }

          if (state is SignedOutFailed) {
            getIt.get<AppLoadingDialog>().popDialog(context: _globalContext);
            ActionDialogs.showAction(
                context: _globalContext,
                barrierDismissible: false,
                title: SConfig.current.error,
                message: state.listDataMessage![0],
                rightLabel: S.current.tryAgain,
                callBackRight: () => _navigator.pop(context));
          }

          if (state is AuthenticationLoading) {
            getIt.get<AppLoadingDialog>().showDefault(_globalContext);
          }

          if (state is AuthenticatedAndNotSignIn) {
            // authenticated but not yet sign in-> push to sign in screen
            getIt.get<AppLoadingDialog>().popDialog();
            _navigator.pushNamedAndRemoveUntil(
                AuthenticationRoute.signInID, (route) => false,
                arguments: {AuthenticationRoute.phoneArg: state.phone});
            return;
          }

          if (state is AuthenticatedAndSignedIn && state.autoPush) {
            // authenticated and signed in -> push to home screen
            _navigator.pushReplacementNamed(
              AppPickRoute.id,
            );
            return;
          }

          if (state is UnAuthenticated) {
            // unauthenticated -> push to on board
            getIt.get<AppLoadingDialog>().popDialog();
            _navigator.pushNamedAndRemoveUntil(
              OnBoardingRoute.id,
              (route) => false,
            );
            return;
          }
        })
      ],
      child: MediaQuery(
        ///Setting font does not change with system font size
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: getProviders,
      child: GestureDetector(
        onTap: _unFocusGlobal,
        child: MaterialApp(
          title: widget.title,
          navigatorKey: _navigatorKey,
          theme: AppThemes.defaultTheme(),
          builder: (context, widget) => _builder(context, widget),
          localizationsDelegates: [
            S.delegate,
            SConfig.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: Locale(widget.locale),
          supportedLocales: S.delegate.supportedLocales,
          initialRoute: widget.isDev ? DevTestRoute.id : SplashRoute.id,
          onGenerateRoute: manifest,
        ),
      ),
    );
  }
}
