// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airdrop_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AirdropModelAdapter extends TypeAdapter<AirdropModel> {
  @override
  final int typeId = 1;

  @override
  AirdropModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AirdropModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as int,
      fields[3] as String,
      fields[4] as String,
      fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AirdropModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.airdropName)
      ..writeByte(2)
      ..write(obj.repeatTime)
      ..writeByte(3)
      ..write(obj.typeReminder)
      ..writeByte(4)
      ..write(obj.lastTrigger)
      ..writeByte(5)
      ..write(obj.isScheduled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AirdropModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirdropModel _$AirdropModelFromJson(Map<String, dynamic> json) => AirdropModel(
      json['id'] as String,
      json['airdropName'] as String,
      (json['repeatTime'] as num).toInt(),
      json['typeReminder'] as String,
      json['lastTrigger'] as String,
      (json['isScheduled'] as num).toInt(),
    );

Map<String, dynamic> _$AirdropModelToJson(AirdropModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'airdropName': instance.airdropName,
      'repeatTime': instance.repeatTime,
      'typeReminder': instance.typeReminder,
      'lastTrigger': instance.lastTrigger,
      'isScheduled': instance.isScheduled,
    };
