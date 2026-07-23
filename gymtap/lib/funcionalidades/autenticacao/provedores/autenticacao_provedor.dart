import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositorios/autenticacao_repositorio.dart';

/// Disponibiliza o AutenticacaoRepositorio para a UI via Riverpod.
final autenticacaoRepositorioProvedor = Provider<AutenticacaoRepositorio>((ref) {
  return AutenticacaoRepositorio();
});

/// Expõe o status de login (autenticado ou não) para a UI observar.
final statusLoginProvedor = StreamProvider<bool>((ref) {
  final repositorio = ref.watch(autenticacaoRepositorioProvedor);
  return repositorio.observarStatusLogin();
});
