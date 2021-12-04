import 'package:flutter_configuration_module/utility/extentions/string_extension.dart';

import 'package:flutter_test/flutter_test.dart';

enum EnumTest { ENUM_VALUE }
void main() {
  test('enum to name', () {
    expect(
        EnumTest.ENUM_VALUE.toString().enumToName, 'ENUM_VALUE');
  });
}
