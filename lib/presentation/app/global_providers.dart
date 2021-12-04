import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:p2p_borrower/presentation/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:p2p_borrower/presentation/cubits/notification_cubit/notification_cubit.dart';
import 'package:p2p_borrower/presentation/journey/connect_to_social/cubit/connect_social_cubit.dart';
import 'package:p2p_borrower/presentation/journey/home/cubit/home_cubit.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/cubits/payment_manager_cubit/payment_manager_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/cubits/loan_cubit/loan_cubit.dart';

/// Global providers
List<BlocProvider> get getProviders => [
      BlocProvider<AuthenticationCubit>(
          create: (BuildContext context) => getIt.get<AuthenticationCubit>()),
      BlocProvider<NotificationCubit>(
          create: (BuildContext context) => getIt.get<NotificationCubit>()),
      BlocProvider<HomeCubit>(
        create: (_) => getIt<HomeCubit>()..fetchAppData(),
      ),
      BlocProvider<PaymentManagerCubit>(
        create: (_) => getIt.get<PaymentManagerCubit>(),
      ),
      BlocProvider<LoanCubit>(
        create: (_) => getIt.get<LoanCubit>(),
      ),
      BlocProvider<ConnectSocialCubit>(
        create: (_) => getIt.get<ConnectSocialCubit>(),
      ),
    ];
