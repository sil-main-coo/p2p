// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linked_payment_loan_detail_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LinkedPaymentLoanDetailResponseAdapter
    extends TypeAdapter<LinkedPaymentLoanDetailResponse> {
  @override
  final int typeId = 8;

  @override
  LinkedPaymentLoanDetailResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LinkedPaymentLoanDetailResponse(
      id: fields[0] as int?,
      serviceName: fields[1] as String?,
      accountId: fields[2] as String?,
      accountName: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LinkedPaymentLoanDetailResponse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.serviceName)
      ..writeByte(2)
      ..write(obj.accountId)
      ..writeByte(3)
      ..write(obj.accountName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LinkedPaymentLoanDetailResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
