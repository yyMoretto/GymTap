import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositorios/treino_repositorio.dart';

/// Disponibiliza o TreinoRepositorio para a UI via Riverpod.
final treinoRepositorioProvedor = Provider<TreinoRepositorio>((ref) {
  return TreinoRepositorio();
});
