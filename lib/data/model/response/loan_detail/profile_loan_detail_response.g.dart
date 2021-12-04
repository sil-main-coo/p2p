// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_loan_detail_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileLoanDetailResponseAdapter
    extends TypeAdapter<ProfileLoanDetailResponse> {
  @override
  final int typeId = 7;

  @override
  ProfileLoanDetailResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileLoanDetailResponse(
      idCardIssuedBy: fields[7] as String?,
      id: fields[0] as int?,
      phone: fields[1] as String?,
      fullName: fields[3] as String?,
      idCardNumber: fields[6] as String?,
      dateOfBirth: fields[5] as dynamic,
      idCardIssuedDate: fields[8] as dynamic,
      gender: fields[4] as String?,
      facebook: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileLoanDetailResponse obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.facebook)
      ..writeByte(3)
      ..write(obj.fullName)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.dateOfBirth)
      ..writeByte(6)
      ..write(obj.idCardNumber)
      ..writeByte(7)
      ..write(obj.idCardIssuedBy)
      ..writeByte(8)
      ..write(obj.idCardIssuedDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileLoanDetailResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
