// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthEntityAdapter extends TypeAdapter<AuthEntity> {
  @override
  final int typeId = 2;

  @override
  AuthEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthEntity(
      email: fields[0] as String,
      userInfo: fields[1] as UserInfoModel,
    );
  }

  @override
  void write(BinaryWriter writer, AuthEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.userInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
