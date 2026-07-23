import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositorios/configuracoes_repositorio.dart';

/// Disponibiliza o ConfiguracoesRepositorio para a UI via Riverpod.
final configuracoesRepositorioProvedor = Provider<ConfiguracoesRepositorio>((ref) {
  return ConfiguracoesRepositorio();
});
