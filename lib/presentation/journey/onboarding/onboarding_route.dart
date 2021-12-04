import 'package:flutter_configuration_module/route/route_define.dart';
import 'package:p2p_borrower/presentation/journey/onboarding/onboarding_screen.dart';

class OnBoardingRoute extends RouteDefine {
  static const id = 'boarding';

  @override
  List<Path> initRoute(Object? arguments) => [
    Path(
        name: id,
        builder: (_) => OnBoardingScreen()),
  ];
}
