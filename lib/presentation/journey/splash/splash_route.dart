import 'package:flutter_configuration_module/route/route_define.dart';
import 'package:p2p_borrower/presentation/journey/splash/splash_screen.dart';

class SplashRoute extends RouteDefine {
  static const id = 'splash';

  @override
  List<Path> initRoute(Object? arguments) => [
        Path(name: id, builder: (_) => SplashScreen()),
      ];
}
