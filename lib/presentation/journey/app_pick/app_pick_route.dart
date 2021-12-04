import 'package:flutter_configuration_module/route/route_define.dart';

import 'app_pick_screen.dart';

class AppPickRoute extends RouteDefine {
  static const id = 'app-pick';

  @override
  List<Path> initRoute(Object? arguments) => [
        Path(name: id, builder: (_) => AppPickScreen()),
      ];
}
