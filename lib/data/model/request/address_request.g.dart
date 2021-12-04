// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddressRequestAdapter extends TypeAdapter<AddressRequest> {
  @override
  final int typeId = 11;

  @override
  AddressRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddressRequest(
      level1_Id: fields[0] as String?,
      level2_Id: fields[1] as String?,
      level3_Id: fields[2] as String?,
      detail: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AddressRequest obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.level1_Id)
      ..writeByte(1)
      ..write(obj.level2_Id)
      ..writeByte(2)
      ..write(obj.level3_Id)
      ..writeByte(3)
      ..write(obj.detail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddressRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
