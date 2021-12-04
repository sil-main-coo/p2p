// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_info_loan_detail_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdditionalInfoLoanDetailResponseAdapter
    extends TypeAdapter<AdditionalInfoLoanDetailResponse> {
  @override
  final int typeId = 9;

  @override
  AdditionalInfoLoanDetailResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdditionalInfoLoanDetailResponse(
      loanProductAdditionalInfoId: fields[0] as int?,
      infoName: fields[1] as String?,
      infoFormat: fields[2] as String?,
      value: fields[3] as String?,
      binaryValue: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AdditionalInfoLoanDetailResponse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.loanProductAdditionalInfoId)
      ..writeByte(1)
      ..write(obj.infoName)
      ..writeByte(2)
      ..write(obj.infoFormat)
      ..writeByte(3)
      ..write(obj.value)
      ..writeByte(4)
      ..write(obj.binaryValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdditionalInfoLoanDetailResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
