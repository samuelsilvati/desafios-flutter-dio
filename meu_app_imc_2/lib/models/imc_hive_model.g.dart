// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IMCHiveModelAdapter extends TypeAdapter<IMCHiveModel> {
  @override
  final int typeId = 1;

  @override
  IMCHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IMCHiveModel()
      ..peso = fields[0] as double
      ..altura = fields[1] as double
      ..resultado = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, IMCHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.peso)
      ..writeByte(1)
      ..write(obj.altura)
      ..writeByte(2)
      ..write(obj.resultado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IMCHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
