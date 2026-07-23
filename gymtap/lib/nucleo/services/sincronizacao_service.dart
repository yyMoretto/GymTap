import 'package:connectivity_plus/connectivity_plus.dart';

import 'firebase_service.dart';

/// Responsável por sincronizar dados entre o banco local (Isar) e o
/// Firebase, seguindo a estratégia Offline First.
///
/// Regra de conflito: Last Write Wins (a escrita mais recente vence).
/// Este service nunca é chamado pela UI — apenas pelos Repositories,
/// e somente depois que a escrita local já foi concluída.
class SincronizacaoService {
  SincronizacaoService();

  /// Verifica se há conexão com a internet e se o Firebase está
  /// disponível antes de tentar qualquer sincronização.
  Future<bool> podeSincronizar() async {
    if (!FirebaseService.estaDisponivel) return false;
    final resultado = await Connectivity().checkConnectivity();
    return !resultado.contains(ConnectivityResult.none);
  }

  /// Envia alterações pendentes do Isar para o Firebase.
  ///
  /// A implementação concreta (o que sincronizar e como resolver
  /// conflitos por Last Write Wins) será feita por funcionalidade,
  /// dentro de cada Repository, reutilizando este service.
  Future<void> sincronizarPendentes() async {
    final conectado = await podeSincronizar();
    if (!conectado) return;

    // TODO: implementar sincronização real por funcionalidade
    // (treino, histórico, perfil, etc.) quando os modelos existirem.
  }
}
