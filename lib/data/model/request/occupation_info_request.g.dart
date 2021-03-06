// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occupation_info_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OccupationInfoStepRequestAdapter
    extends TypeAdapter<OccupationInfoStepRequest> {
  @override
  final int typeId = 10;

  @override
  OccupationInfoStepRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OccupationInfoStepRequest(
      occupationCode: fields[0] as String?,
      occupationName: fields[1] as String?,
      occupationPosition: fields[2] as String?,
      occupationAddress: fields[3] as AddressRequest?,
      workplaceName: fields[4] as String?,
      monthlyIncome: fields[5] as int?,
      workplacePhone: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OccupationInfoStepRequest obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.occupationCode)
      ..writeByte(1)
      ..write(obj.occupationName)
      ..writeByte(2)
      ..write(obj.occupationPosition)
      ..writeByte(3)
      ..write(obj.occupationAddress)
      ..writeByte(4)
      ..write(obj.workplaceName)
      ..writeByte(5)
      ..write(obj.monthlyIncome)
      ..writeByte(6)
      ..write(obj.workplacePhone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OccupationInfoStepRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
