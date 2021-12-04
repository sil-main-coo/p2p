import 'package:p2p_borrower/data/model/response/device_info_response.dart';
import 'package:p2p_borrower/data/sources/local/device_local_source.dart';
import 'package:p2p_borrower/domain/repositories/device_repository.dart';

class DeviceRepoImplement implements DeviceRepository {
  final DeviceLocalSource deviceLocalSource;

  DeviceRepoImplement({required this.deviceLocalSource});

  @override
  Future<DeviceInfoResponse> getDeviceDetails() =>
      deviceLocalSource.getDeviceDetails();
}
