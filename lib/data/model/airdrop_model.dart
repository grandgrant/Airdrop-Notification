import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'airdrop_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class AirdropModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String airdropName;
  @HiveField(2)
  int repeatTime;
  @HiveField(3)
  String typeReminder;
  @HiveField(4)
  String lastTrigger;
  @HiveField(5)
  int isScheduled;

  AirdropModel(this.id, this.airdropName, this.repeatTime, this.typeReminder,
      this.lastTrigger, this.isScheduled);

  factory AirdropModel.fromJson(Map<String, dynamic> json) =>
      _$AirdropModelFromJson(json);

  Map<String, dynamic> toJson() => _$AirdropModelToJson(this);
}
