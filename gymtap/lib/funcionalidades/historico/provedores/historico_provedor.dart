import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositorios/historico_repositorio.dart';

/// Disponibiliza o HistoricoRepositorio para a UI via Riverpod.
final historicoRepositorioProvedor = Provider<HistoricoRepositorio>((ref) {
  return HistoricoRepositorio();
});
