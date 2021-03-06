// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_application_detail_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoanApplicationDetailResponseAdapter
    extends TypeAdapter<LoanApplicationDetailResponse> {
  @override
  final int typeId = 5;

  @override
  LoanApplicationDetailResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoanApplicationDetailResponse(
      id: fields[0] as int?,
      loanProductId: fields[1] as int?,
      loanProduct: fields[2] as String?,
      interestRate: fields[3] as int?,
      fees: fields[4] as int?,
      linkedPayment: fields[5] as LinkedPaymentLoanDetailResponse?,
      occupation: fields[6] as OccupationInfoStepRequest?,
      relativePerson1: fields[7] as RelativePersonRequest?,
      relativePerson2: fields[8] as RelativePersonRequest?,
      profile: fields[9] as ProfileLoanDetailResponse?,
      residentAddress: fields[10] as AddressRequest?,
      currentAddress: fields[11] as AddressRequest?,
      additionalInfos:
          (fields[12] as List?)?.cast<AdditionalInfoLoanDetailResponse>(),
      ownedType: fields[13] as String?,
      maritalStatusId: fields[14] as int?,
      maritalStatus: fields[15] as String?,
      idCardWithUserImage: fields[16] as String?,
      idCardFrontImage: fields[17] as String?,
      idCardBackImage: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LoanApplicationDetailResponse obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.loanProductId)
      ..writeByte(2)
      ..write(obj.loanProduct)
      ..writeByte(3)
      ..write(obj.interestRate)
      ..writeByte(4)
      ..write(obj.fees)
      ..writeByte(5)
      ..write(obj.linkedPayment)
      ..writeByte(6)
      ..write(obj.occupation)
      ..writeByte(7)
      ..write(obj.relativePerson1)
      ..writeByte(8)
      ..write(obj.relativePerson2)
      ..writeByte(9)
      ..write(obj.profile)
      ..writeByte(10)
      ..write(obj.residentAddress)
      ..writeByte(11)
      ..write(obj.currentAddress)
      ..writeByte(12)
      ..write(obj.additionalInfos)
      ..writeByte(13)
      ..write(obj.ownedType)
      ..writeByte(14)
      ..write(obj.maritalStatusId)
      ..writeByte(15)
      ..write(obj.maritalStatus)
      ..writeByte(16)
      ..write(obj.idCardWithUserImage)
      ..writeByte(17)
      ..write(obj.idCardFrontImage)
      ..writeByte(18)
      ..write(obj.idCardBackImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoanApplicationDetailResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
