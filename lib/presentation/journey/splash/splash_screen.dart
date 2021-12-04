import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_configuration_module/utility/utils/utils.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:p2p_borrower/common/constants/image_constants.dart';
import 'package:p2p_borrower/generated/l10n.dart';
import 'package:p2p_borrower/presentation/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:p2p_borrower/presentation/cubits/notification_cubit/notification_cubit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _checkAuthentication() {
    BlocProvider.of<NotificationCubit>(context).initialApp();
    BlocProvider.of<AuthenticationCubit>(context).checkAuthentication();
  }

  @override
  void initState() {
    super.initState();
    Utils.afterBuild(_checkAuthentication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Image.asset(ImageConstants.logo),
          ),
          Positioned(
              bottom: 24.h,
              child: Text(
                S.current.splashText,
                style: Theme.of(context).textTheme.caption,
              ))
        ],
      ),
    );
  }
}
