import 'package:p2p_borrower/data/model/response/device_info_response.dart';

abstract class DeviceRepository{
  Future<DeviceInfoResponse> getDeviceDetails();
}