// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relative_person_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RelativePersonRequestAdapter extends TypeAdapter<RelativePersonRequest> {
  @override
  final int typeId = 6;

  @override
  RelativePersonRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RelativePersonRequest(
      typeId: fields[1] as int?,
      phone: fields[2] as String?,
      name: fields[3] as String?,
      id: fields[0] as int?,
      type: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RelativePersonRequest obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.typeId)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RelativePersonRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
