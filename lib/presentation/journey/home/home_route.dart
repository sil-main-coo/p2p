import 'package:flutter_configuration_module/route/route_define.dart';
import 'package:p2p_borrower/presentation/journey/connect_to_social/cubit/connect_social_cubit.dart';
import 'package:p2p_borrower/presentation/journey/home/cubit/home_cubit.dart';
import 'package:p2p_borrower/presentation/journey/home/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p2p_borrower/presentation/journey/linking_payment/cubits/payment_manager_cubit/payment_manager_cubit.dart';
import 'package:p2p_borrower/presentation/journey/loan/cubits/loan_cubit/loan_cubit.dart';

class HomeRoute extends RouteDefine {
  static const id = 'home';

  @override
  List<Path> initRoute(Object? arguments) {
    // final args = arguments == null ? null : arguments as Map;
    return [
      Path(
          name: id,
          builder: (context) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: BlocProvider.of<HomeCubit>(context)..fetchAppData(),
                  ),
                  BlocProvider.value(
                    value: BlocProvider.of<LoanCubit>(context)
                      ..fetchLoanApplications(),
                  ),
                  BlocProvider.value(
                    value: BlocProvider.of<PaymentManagerCubit>(context)
                      ..fetchLinkedPayment(),
                  ),
                  BlocProvider.value(
                    value: BlocProvider.of<ConnectSocialCubit>(context)
                      ..fetchData(),
                  ),
                ],
                child: HomeScreen(),
              )),
    ];
  }
}
