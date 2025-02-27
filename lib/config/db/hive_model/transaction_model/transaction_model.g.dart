// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionEntityAdapter extends TypeAdapter<TransactionEntity> {
  @override
  final int typeId = 3;

  @override
  TransactionEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionEntity(
      email: fields[0] as String,
      dateTime: fields[1] as DateTime,
      cartProduct: (fields[2] as List).cast<ProductEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, TransactionEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.cartProduct);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
