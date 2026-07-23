import 'package:firebase_core/firebase_core.dart';

/// Responsável exclusivamente pela inicialização e disponibilidade do
/// Firebase. Nenhuma tela ou repository deve chamar o Firebase
/// diretamente — o acesso passa por este service (ou pelos services
/// que o utilizam, como autenticação e sincronização).
class FirebaseService {
  FirebaseService._();

  static bool _inicializado = false;

  /// Indica se o Firebase foi inicializado com sucesso.
  /// Usado pelo service de sincronização para decidir se pode
  /// tentar comunicação com a nuvem.
  static bool get estaDisponivel => _inicializado;

  /// Inicializa o Firebase de forma segura.
  ///
  /// Offline First: se a inicialização falhar (ex: sem internet na
  /// primeira execução), o app deve continuar funcionando normalmente
  /// no modo local. A falha aqui nunca é crítica.
  static Future<void> inicializar() async {
    if (_inicializado) return;
    try {
      await Firebase.initializeApp();
      _inicializado = true;
    } catch (_) {
      _inicializado = false;
    }
  }
}
