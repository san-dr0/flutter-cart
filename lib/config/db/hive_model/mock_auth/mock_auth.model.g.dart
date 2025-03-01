// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mock_auth.model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MockAuthModelAdapter extends TypeAdapter<MockAuthModel> {
  @override
  final int typeId = 4;

  @override
  MockAuthModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MockAuthModel(
      email: fields[0] as String,
      firstName: fields[1] as String,
      middleName: fields[2] as String,
      lastName: fields[3] as String,
      password: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MockAuthModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.middleName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MockAuthModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
