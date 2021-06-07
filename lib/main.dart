import 'package:cuida_pet/app/core/push_notification/firebase_mensage_configure.dart';
import 'package:flutter/material.dart';
import 'package:cuida_pet/app/app_module.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  loadEnv();
  FirebaseMensageConfigure().configure();
  runApp(ModularApp(module: AppModule()));
}

Future<void> loadEnv() async {
  const isProduction = bool.fromEnvironment('dart.vm.product');
  await DotEnv().load(isProduction ? '.env' : '.env_dev');
}
