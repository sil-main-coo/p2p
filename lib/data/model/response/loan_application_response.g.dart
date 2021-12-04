// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_application_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoanApplicationResponseAdapter
    extends TypeAdapter<LoanApplicationResponse> {
  @override
  final int typeId = 4;

  @override
  LoanApplicationResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoanApplicationResponse(
      id: fields[0] as int?,
      expectedTotalPayment: fields[17] as double?,
      iconPath: fields[15] as String?,
      icon: fields[14] as String?,
      iconLastModifiedDate: fields[16] as int?,
      loanProduct: fields[2] as String?,
      loanDuration: fields[3] as int?,
      durationUnit: fields[4] as String?,
      status: fields[5] as String?,
      loanAmountActual: fields[20] as int?,
      loanAmount: fields[6] as int?,
      raisedAmount: fields[7] as int?,
      debtAmount: fields[8] as int?,
      statusDisplay: fields[9] as String?,
      interestRate: fields[10] as double?,
      serviceFees: fields[11] as double?,
      phone: fields[12] as String?,
      createDate: fields[13] as int?,
    )
      ..amountUnit = fields[1] as String?
      ..expectedTotalPaymentActual = fields[18] as int?
      ..serviceFeesActual = fields[19] as int?;
  }

  @override
  void write(BinaryWriter writer, LoanApplicationResponse obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amountUnit)
      ..writeByte(2)
      ..write(obj.loanProduct)
      ..writeByte(3)
      ..write(obj.loanDuration)
      ..writeByte(4)
      ..write(obj.durationUnit)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.loanAmount)
      ..writeByte(7)
      ..write(obj.raisedAmount)
      ..writeByte(8)
      ..write(obj.debtAmount)
      ..writeByte(9)
      ..write(obj.statusDisplay)
      ..writeByte(10)
      ..write(obj.interestRate)
      ..writeByte(11)
      ..write(obj.serviceFees)
      ..writeByte(12)
      ..write(obj.phone)
      ..writeByte(13)
      ..write(obj.createDate)
      ..writeByte(14)
      ..write(obj.icon)
      ..writeByte(15)
      ..write(obj.iconPath)
      ..writeByte(16)
      ..write(obj.iconLastModifiedDate)
      ..writeByte(17)
      ..write(obj.expectedTotalPayment)
      ..writeByte(18)
      ..write(obj.expectedTotalPaymentActual)
      ..writeByte(19)
      ..write(obj.serviceFeesActual)
      ..writeByte(20)
      ..write(obj.loanAmountActual);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoanApplicationResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
