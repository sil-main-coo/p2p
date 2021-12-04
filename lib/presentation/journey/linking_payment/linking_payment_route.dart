import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:flutter_configuration_module/route/route_define.dart';

import 'acttion_payment_screen_enum.dart';
import 'add_payment/add_linking_payment_screen.dart';
import 'linking_payment_fragment.dart';
import 'cubits/linking_payment_cubit/linking_payment_cubit.dart';

class LinkingPaymentRoute extends RouteDefine {
  static const id = 'linking-payment';
  static const addLinkingPaymentID = 'add-linking-payment';

  static const argLinkingPayments = 'arg-linking-payments';

  @override
  List<Path> initRoute(Object? arguments) {
    Map<String, dynamic>? args;

    if (arguments != null) {
      args = arguments as Map<String, dynamic>;
    }

    return [
      Path(
          name: addLinkingPaymentID,
          builder: (_) => BlocProvider(
              create: (_) => getIt.get<LinkingPaymentCubit>()..fetchData(),
              child: AddLinkingPaymentScreen())),
      Path(
          name: id,
          builder: (_) => LinkingPaymentFragment(
                action: ActionPaymentScreenEnum.MANAGER,
              )),
    ];
  }
}
