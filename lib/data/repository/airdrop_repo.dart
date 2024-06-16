import 'dart:convert';

import 'package:airdrop_notification/data/model/airdrop_model.dart';
import 'package:airdrop_notification/utils/hive.dart';
import 'package:hive/hive.dart';

class AirdropRepo {
  // Future<List<AirdropModel>> getAllAirdrop() async {
  //   Box<List> airdropBox = await HiveUtils.getInstance('airdrop');

  //   List listAirdrop = airdropBox.get('listAirdrop') ?? [];

  //   print(listAirdrop[0]);

  //   return listAirdrop;
  // }

  // Future<List<AirdropModel>> addAirdrop(AirdropModel airdrop) async {
  //   Box<List<AirdropModel>> airdropBox = await HiveUtils.getInstance('airdrop');
  //   List<AirdropModel> listAirdrop = airdropBox.get('listAirdrop') ?? [];

  //   listAirdrop.add(airdrop);

  //   airdropBox.put('listAirdrop', listAirdrop);

  //   return listAirdrop;
  // }

  // Future<List<AirdropModel>> removeAirdrop(String id) async {
  //   Box<dynamic> airdropBox = await HiveUtils.getInstance('airdrop');
  //   String sListAirdrop = airdropBox.get('listAirdrop');
  //   List<AirdropModel> listAirdrop = jsonDecode(sListAirdrop);

  //   if (listAirdrop.isNotEmpty) {
  //     listAirdrop.removeWhere((element) => element.id == id);
  //   }

  //   String newSListAirdrop = jsonEncode(listAirdrop);
  //   airdropBox.put('listAirdrop', newSListAirdrop);

  //   return listAirdrop;
  // }

  // Future<void> setScheduleStatus(String id) async {
  //   Box<dynamic> airdropBox = await HiveUtils.getInstance('airdrop');
  //   List<AirdropModel> listAirdrop = airdropBox.get('listAirdrop') ?? [];
  //   listAirdrop.map((airdrop) {
  //     if (airdrop.id == id) {
  //       airdrop.isScheduled = 1;
  //     }
  //     return airdrop;
  //   }).toList();

  //   airdropBox.put('listAirdrop', listAirdrop);
  // }
}
