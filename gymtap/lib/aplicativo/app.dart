import 'package:flutter/material.dart';

import '../nucleo/utilitarios/constantes.dart';
import 'tema/app_tema.dart';

/// Widget raiz do GymTap.
///
/// Ainda não define rotas de funcionalidades — elas serão adicionadas
/// conforme cada uma for implementada (autenticação, treino, etc).
class GymTapApp extends StatelessWidget {
  const GymTapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppTextos.nomeApp,
      debugShowCheckedModeBanner: false,
      theme: AppTema.escuro,
      home: const _TelaBaseTemporaria(),
    );
  }
}

/// Tela temporária apenas para validar o setup inicial do projeto.
/// Será substituída pela navegação real assim que as funcionalidades
/// (autenticação, treino, etc.) forem implementadas.
class _TelaBaseTemporaria extends StatelessWidget {
  const _TelaBaseTemporaria();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('GymTap — base do projeto configurada.'),
      ),
    );
  }
}
