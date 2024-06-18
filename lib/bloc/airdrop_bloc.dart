import 'dart:math';

import 'package:airdrop_notification/data/model/airdrop_model.dart';
import 'package:airdrop_notification/data/repository/airdrop_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/locale.dart';
import 'package:meta/meta.dart';
import 'package:schedulers/schedulers.dart';
import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

part 'airdrop_event.dart';
part 'airdrop_state.dart';

class AirdropBloc extends HydratedBloc<AirdropEvent, AirdropState> {
  //TODO learn hydratedbloc to smooth get state
  final AirdropRepo airdropRepo = AirdropRepo();

  List<AirdropModel> listAirdrop = [];

  AirdropBloc() : super(const AirdropInitial()) {
    on<AirdropListGet>(
      (event, emit) async {
        try {
          emit(AirdropLoading());
          emit(AirdropLoaded(listAirdrop));
        } catch (error) {
          emit(AirdropError(error.toString()));
        }
      },
    );
    on<AirdropAdd>((event, emit) async {
      try {
        emit(AirdropLoading());
        Uuid uuid = Uuid(goptions: GlobalOptions(CryptoRNG()));
        String id = uuid.v4();

        AirdropModel airdrop = AirdropModel(
            id, event.aridropName, event.interval, event.type, "", 0);

        // listAirdrop = await airdropRepo.addAirdrop(airdrop);
        listAirdrop.add(airdrop);

        emit(AirdropLoaded(listAirdrop));
      } catch (error) {
        emit(AirdropError(error.toString()));
      }
    });
    on<AirdropDelete>((event, emit) {});

    on<AirdropStartSchedule>((event, emit) async {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      bool? permissionNotification = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();

      if (permissionNotification != null) {
        if (permissionNotification) {
          String id = event.id;

          AirdropModel airdrop =
              listAirdrop.where((element) => element.id == id).first;

          List<AirdropModel> modifiedListAirdrop = listAirdrop.map((e) {
            if (e.id == airdrop.id) {
              e.isScheduled = 1;
            }
            return e;
          }).toList();

          final schedulerAirdrop = TimeScheduler();
          DateTime dateTime =
              DateTime.now().add(Duration(minutes: airdrop.repeatTime));

          schedulerAirdrop.run(() {
            AndroidNotificationDetails androidNotificationDetails =
                AndroidNotificationDetails(
                    'your channel id', 'your channel name',
                    channelDescription: 'your channel description',
                    importance: Importance.max,
                    priority: Priority.high,
                    ticker: airdrop.airdropName);

            NotificationDetails notificationDetails =
                NotificationDetails(android: androidNotificationDetails);

            flutterLocalNotificationsPlugin.show(
                Random.secure().nextInt(99999),
                airdrop.airdropName,
                "Dont forget to claim token",
                notificationDetails,
                payload: id);
          }, dateTime);

          emit(AirdropLoading());

          emit(AirdropLoaded(modifiedListAirdrop));
        } else {
          const AirdropError("Please accept permission");
        }
      }
    });

    on<AirdropFinishSchedule>((event, emit) {
      String id = event.id;

      List<AirdropModel> newListAirdrop = listAirdrop.map((e) {
        if (e.id == id) {
          e.isScheduled = 0;
          e.lastTrigger = DateFormat('HH:mm:ss').format(DateTime.now());
        }

        return e;
      }).toList();

      emit(AirdropLoading());

      emit(AirdropLoaded(newListAirdrop));
    });
  }

  @override
  AirdropState? fromJson(Map<String, dynamic> json) {
    if ((json['listAirdrop'] as List).isNotEmpty) {
      List<dynamic> listJsonAirdrop = json['listAirdrop'];

      for (var element in listJsonAirdrop) {
        Map<String, dynamic> jsonAirdrop = element;
        AirdropModel airdrop = AirdropModel.fromJson(jsonAirdrop);
        listAirdrop.add(airdrop);
      }
      return AirdropLoaded(listAirdrop);
    }

    return const AirdropLoaded([]);
  }

  @override
  Map<String, dynamic>? toJson(AirdropState state) {
    if (state is AirdropLoaded) {
      return {"listAirdrop": state.listAirdrop};
    } else {
      return {"listAirdrop": []};
    }
  }
}
