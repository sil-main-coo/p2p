import 'package:flutter_configuration_module/route/route_define.dart';
import 'package:p2p_borrower/presentation/journey/connect_to_social/connect_facebook_screen.dart';

class ConnectSocialRoute extends RouteDefine {
  static const connectFacebookID = 'connect-fb-id';

  @override
  List<Path> initRoute(Object? arguments) => [
    Path(
        name: connectFacebookID,
        builder: (_) => ConnectFacebookScreen()),
  ];
}
