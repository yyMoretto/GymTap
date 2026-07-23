import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositorios/perfil_repositorio.dart';

/// Disponibiliza o PerfilRepositorio para a UI via Riverpod.
final perfilRepositorioProvedor = Provider<PerfilRepositorio>((ref) {
  return PerfilRepositorio();
});
