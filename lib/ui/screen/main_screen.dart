import 'package:airdrop_notification/bloc/airdrop_bloc.dart';
import 'package:airdrop_notification/data/model/airdrop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    BlocProvider.of<AirdropBloc>(context).add(AirdropListGet());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed('addAirdrop');
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
        body: Container(
          color: Colors.blue,
          child: BlocBuilder<AirdropBloc, AirdropState>(
            builder: (context, state) {
              if (state is AirdropInitial) {
                return const SizedBox();
              }

              if (state is AirdropLoading) {
                return Center(
                    child: LoadingAnimationWidget.waveDots(
                        color: Colors.white, size: 50));
              }

              if (state is AirdropLoaded) {
                print("Loaded");
                if (state.listAirdrop.isEmpty) {
                  return const Center(
                    child: Text(
                      "List is empty. Please insert first",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                } else {
                  List<AirdropModel> listAirdrop = state.listAirdrop;

                  return ListView.separated(
                    itemBuilder: (listContext, index) {
                      AirdropModel airdrop = listAirdrop[index];
                      return GestureDetector(
                        onDoubleTap: () {
                          BlocProvider.of<AirdropBloc>(context)
                              .add(AirdropStartSchedule(airdrop.id));
                        },
                        child: Card(
                          color: airdrop.isScheduled == 1
                              ? Colors.green
                              : Colors.white,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  airdrop.airdropName,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Interval",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text("${airdrop.repeatTime} Jam"),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Text(
                                            "Last Notification",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(airdrop.lastTrigger.isEmpty
                                              ? "-"
                                              : airdrop.lastTrigger),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Tipe",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(state.listAirdrop[index].typeReminder),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (separatorContext, index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: state.listAirdrop.length,
                  );
                }
              }

              if (state is AirdropError) {
                return Center(
                  child: Text(
                    state.errMessage,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ));
  }
}
