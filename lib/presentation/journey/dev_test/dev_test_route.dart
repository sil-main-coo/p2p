import 'package:flutter_configuration_module/route/route_define.dart';
import 'package:p2p_borrower/presentation/journey/dev_test/dev_test_screen.dart';

class DevTestRoute extends RouteDefine {
  static const id = 'dev-test';

  @override
  List<Path> initRoute(Object? arguments) => [
        Path(name: id, builder: (_) => DevTestScreen()),
      ];
}
