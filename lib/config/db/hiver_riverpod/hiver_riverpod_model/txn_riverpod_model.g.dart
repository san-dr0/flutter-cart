// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'txn_riverpod_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionHistoryRiverpodModelAdapter
    extends TypeAdapter<TransactionHistoryRiverpodModel> {
  @override
  final int typeId = 9;

  @override
  TransactionHistoryRiverpodModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionHistoryRiverpodModel(
      id: fields[0] as String,
      email: fields[1] as String,
      cartList: (fields[2] as List).cast<ProductEntryRiverPodModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TransactionHistoryRiverpodModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.cartList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionHistoryRiverpodModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
