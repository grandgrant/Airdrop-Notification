import 'package:airdrop_notification/bloc/airdrop_bloc.dart';
import 'package:airdrop_notification/data/model/airdrop_model.dart';
import 'package:airdrop_notification/data/repository/airdrop_repo.dart';
import 'package:airdrop_notification/ui/screen/add_airdrop_screen.dart';
import 'package:airdrop_notification/ui/screen/main_screen.dart';
import 'package:airdrop_notification/ui/screen/splash_screen.dart';
import 'package:airdrop_notification/utils/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveUtils.initHive();

  Hive.registerAdapter(AirdropModelAdapter());

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: true,
            create: (context) => AirdropBloc(),
          )
        ],
        child: MaterialApp.router(
          title: 'Airdrop Notification',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          routerConfig: GoRouter(routes: [
            GoRoute(
              name: "splash",
              path: '/',
              builder: (context, state) => const SplashScreen(),
            ),
            GoRoute(
              name: "main",
              path: '/home',
              builder: (context, state) => const MainScreen(),
            ),
            GoRoute(
              name: "addAirdrop",
              path: '/add',
              builder: (context, state) => const AddAirdropScreen(),
            )
          ], debugLogDiagnostics: true),
        ));
  }
}
