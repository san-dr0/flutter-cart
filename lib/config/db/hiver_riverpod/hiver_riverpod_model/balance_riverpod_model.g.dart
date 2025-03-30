// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_riverpod_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BalanceRiverpodModelAdapter extends TypeAdapter<BalanceRiverpodModel> {
  @override
  final int typeId = 9;

  @override
  BalanceRiverpodModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BalanceRiverpodModel(
      currentBalance: fields[0] as double,
    );
  }

  @override
  void write(BinaryWriter writer, BalanceRiverpodModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.currentBalance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BalanceRiverpodModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
