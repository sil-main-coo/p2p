// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_products_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoanProductsResponseAdapter extends TypeAdapter<LoanProductsResponse> {
  @override
  final int typeId = 1;

  @override
  LoanProductsResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoanProductsResponse(
      id: fields[0] as int?,
      typeCode: fields[1] as String?,
      name: fields[2] as String?,
      description: fields[3] as String?,
      minimumAmount: fields[4] as int?,
      maximumAmount: fields[5] as int?,
      amountUnit: fields[6] as String?,
      minimumDuration: fields[7] as int?,
      maximumDuration: fields[8] as int?,
      icon: fields[11] as String?,
      iconPath: fields[12] as String?,
      iconLastModifiedDate: fields[13] as DateTime?,
      durationUnit: fields[9] as String?,
      additionalInfos: (fields[10] as List?)?.cast<AdditionalInfos>(),
    );
  }

  @override
  void write(BinaryWriter writer, LoanProductsResponse obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.typeCode)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.minimumAmount)
      ..writeByte(5)
      ..write(obj.maximumAmount)
      ..writeByte(6)
      ..write(obj.amountUnit)
      ..writeByte(7)
      ..write(obj.minimumDuration)
      ..writeByte(8)
      ..write(obj.maximumDuration)
      ..writeByte(9)
      ..write(obj.durationUnit)
      ..writeByte(10)
      ..write(obj.additionalInfos)
      ..writeByte(11)
      ..write(obj.icon)
      ..writeByte(12)
      ..write(obj.iconPath)
      ..writeByte(13)
      ..write(obj.iconLastModifiedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoanProductsResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AdditionalInfosAdapter extends TypeAdapter<AdditionalInfos> {
  @override
  final int typeId = 2;

  @override
  AdditionalInfos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdditionalInfos(
      id: fields[1] as int?,
      loanTypeId: fields[2] as int?,
      infoName: fields[3] as String?,
      infoFormat: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AdditionalInfos obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.loanTypeId)
      ..writeByte(3)
      ..write(obj.infoName)
      ..writeByte(4)
      ..write(obj.infoFormat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdditionalInfosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
