import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'aplicativo/app.dart';
import 'nucleo/banco_local/isar_database.dart';
import 'nucleo/services/firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Offline First: o banco local é inicializado primeiro. O app precisa
  // estar 100% funcional mesmo que o passo seguinte (Firebase) falhe.
  await inicializarIsar();

  // O Firebase é inicializado em seguida, mas uma falha aqui (ex: sem
  // internet na primeira execução) nunca deve impedir o app de abrir.
  await FirebaseService.inicializar();

  runApp(
    const ProviderScope(
      child: GymTapApp(),
    ),
  );
}
