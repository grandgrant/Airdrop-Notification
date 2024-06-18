part of 'airdrop_bloc.dart';

@immutable
sealed class AirdropEvent {}

class AirdropAdd extends AirdropEvent {
  final String aridropName;
  final int interval;
  final String type;

  AirdropAdd(this.aridropName, this.interval, this.type);
}

class AirdropStartSchedule extends AirdropEvent {
  final String id;

  AirdropStartSchedule(this.id);
}

class AirdropFinishSchedule extends AirdropEvent {
  final String id;

  AirdropFinishSchedule(this.id);
}

class AirdropDelete extends AirdropEvent {
  final String id;
  AirdropDelete(this.id);
}

class AirdropListGet extends AirdropEvent {}
