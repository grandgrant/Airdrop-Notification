import 'package:airdrop_notification/data/model/airdrop_model.dart';
import 'package:airdrop_notification/data/repository/airdrop_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:schedulers/schedulers.dart';
import 'package:uuid/data.dart';
import 'package:uuid/rng.dart';
import 'package:uuid/uuid.dart';

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

    on<AirdropStartSchedule>(
      (event, emit) {
        String id = event.id;

        AirdropModel airdrop =
            listAirdrop.where((element) => element.id == id).first;

        final schedulerAirdrop =
            RateScheduler(1, Duration(hours: airdrop.repeatTime));

        schedulerAirdrop.run(() {});
      },
    );
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
