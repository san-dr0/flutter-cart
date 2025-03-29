// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.signup.riverpod.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthSignupRiverpodModelAdapter
    extends TypeAdapter<AuthSignupRiverpodModel> {
  @override
  final int typeId = 8;

  @override
  AuthSignupRiverpodModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthSignupRiverpodModel(
      firstname: fields[0] as String,
      lastname: fields[1] as String,
      email: fields[2] as String,
      password: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthSignupRiverpodModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.firstname)
      ..writeByte(1)
      ..write(obj.lastname)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthSignupRiverpodModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
