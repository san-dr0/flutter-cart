// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BalanceEntityAdapter extends TypeAdapter<BalanceEntity> {
  @override
  final int typeId = 5;

  @override
  BalanceEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BalanceEntity(
      id: fields[0] as String,
      email: fields[1] as String,
      currentBalance: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, BalanceEntity obj) {
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
      other is BalanceEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
