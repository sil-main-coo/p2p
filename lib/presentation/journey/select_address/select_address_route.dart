import 'package:flutter_configuration_module/route/route_define.dart';

import 'select_address_screen.dart';

class SelectAddressRoute extends RouteDefine {
  static const id = 'select-address';

  static const argTitle = 'select-address-arg-title';
  static const argAddresses = 'select-address-arg-addresses';
  static const argAddressSelected = 'select-address-arg-address-selected';

  @override
  List<Path> initRoute(Object? arguments) {
    Map<String, dynamic>? args;

    if (arguments != null) {
      args = arguments as Map<String, dynamic>;
    }

    return [
      Path(
          name: id,
          builder: (_) => SelectAddressScreen(
                title: args![argTitle],
                addresses: args[argAddresses],
                selected: args[argAddressSelected],
              )),
    ];
  }
}
