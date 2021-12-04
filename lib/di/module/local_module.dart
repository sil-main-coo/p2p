import 'package:device_info/device_info.dart';
import 'package:flutter_configuration_module/di/di_module.dart';
import 'package:p2p_borrower/data/sources/local/device_local_source.dart';
import 'package:p2p_borrower/data/sources/local/loan_application_local_source.dart';
import 'package:p2p_borrower/data/sources/local/loan_master_data_local_source.dart';

class LocalModule extends DIModule {
  @override
  provides() async {
    getIt.registerFactory(() =>
        DeviceLocalSource(deviceInfoPlugin: getIt.get<DeviceInfoPlugin>()));
    getIt.registerFactory(() => LoanMasterDataLocalSource());
    getIt.registerFactory(() => LoanApplicationLocalSource());
  }
}
