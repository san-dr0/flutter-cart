// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_riverpod_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthRiverpodModelAdapter extends TypeAdapter<AuthRiverpodModel> {
  @override
  final int typeId = 7;

  @override
  AuthRiverpodModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthRiverpodModel(
      email: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AuthRiverpodModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthRiverpodModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
