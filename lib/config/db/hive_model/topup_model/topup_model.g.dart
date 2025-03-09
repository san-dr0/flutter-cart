// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topup_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopupEnityAdapter extends TypeAdapter<TopupEnity> {
  @override
  final int typeId = 4;

  @override
  TopupEnity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopupEnity(
      id: fields[0] as int,
      email: fields[1] as String,
      currentBalance: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TopupEnity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.currentBalance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopupEnityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
