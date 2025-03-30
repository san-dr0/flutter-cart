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
      id: fields[0] as String,
      firstname: fields[1] as String,
      lastname: fields[2] as String,
      email: fields[3] as String,
      password: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthSignupRiverpodModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstname)
      ..writeByte(2)
      ..write(obj.lastname)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
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
