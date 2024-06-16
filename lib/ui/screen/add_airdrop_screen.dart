import 'package:airdrop_notification/bloc/airdrop_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddAirdropScreen extends StatefulWidget {
  const AddAirdropScreen({super.key});

  @override
  State<AddAirdropScreen> createState() => _AddAirdropScreenState();
}

class _AddAirdropScreenState extends State<AddAirdropScreen> {
  TextEditingController nameAirdropController = TextEditingController(text: "");
  ValueNotifier<String> intervalValue = ValueNotifier<String>("");
  ValueNotifier<String> typeValue = ValueNotifier<String>("");
  ValueNotifier<String> errTextInterval = ValueNotifier("");
  ValueNotifier<String> errTextType = ValueNotifier("");

  List<int> dataRepeatTime = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 24];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Airdrop"),
          shadowColor: Colors.black,
          elevation: 0.4,
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Add Airdrop",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Nama Airdrop",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                      controller: nameAirdropController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2)),
                      )),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Waktu Notifikasi",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ValueListenableBuilder(
                    valueListenable: errTextInterval,
                    builder: (context, value, child) {
                      return DropdownMenu<String>(
                        dropdownMenuEntries: dataRepeatTime
                            .map((data) => DropdownMenuEntry(
                                value: data.toString(), label: "$data Jam"))
                            .toList(),
                        menuHeight: size.height * 0.25,
                        width: size.width - 50,
                        errorText: value.isEmpty ? null : value,
                        onSelected: (valueDropdown) {
                          intervalValue.value = valueDropdown ?? "1";
                          errTextInterval.value = "";
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Tipe Airdrop",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ValueListenableBuilder(
                    valueListenable: errTextType,
                    builder: (context, value, child) {
                      return DropdownMenu<String>(
                        dropdownMenuEntries: const [
                          DropdownMenuEntry(value: "Tap", label: "Tap"),
                          DropdownMenuEntry(value: "Mining", label: "Mining")
                        ],
                        width: size.width - 50,
                        errorText: value.isEmpty ? null : value,
                        onSelected: (valueDropdown) {
                          typeValue.value = valueDropdown ?? "Tap";
                          errTextType.value = "";
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: () {
                          if (intervalValue.value.isEmpty) {
                            errTextInterval.value = "Harap pilih rentang waktu";
                          } else if (typeValue.value.isEmpty) {
                            errTextType.value = "Harap pilih tipe pengingat";
                          } else {
                            BlocProvider.of<AirdropBloc>(context).add(
                                AirdropAdd(
                                    nameAirdropController.text,
                                    int.parse(intervalValue.value),
                                    typeValue.value));

                            context.goNamed("main");
                          }
                        },
                        style: const ButtonStyle(
                            enableFeedback: true,
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30)),
                            alignment: Alignment.center,
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.amber)),
                        child: const Text(
                          "Add",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  )
                ],
              )),
        ));
  }
}
