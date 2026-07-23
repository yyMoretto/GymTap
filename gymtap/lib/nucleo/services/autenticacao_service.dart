import 'package:firebase_auth/firebase_auth.dart';

/// Integração externa de autenticação (Firebase Auth, Google, Facebook...).
///
/// Contém apenas comunicação com provedores externos de login — nenhuma
/// regra de negócio, cache local ou acesso a dados deve existir aqui.
/// Quem orquestra esse service é o AutenticacaoRepositorio.
class AutenticacaoService {
  AutenticacaoService({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  /// Emite o usuário atual sempre que o estado de login mudar.
  Stream<User?> observarUsuario() => _firebaseAuth.authStateChanges();

  User? get usuarioAtual => _firebaseAuth.currentUser;

  /// Encerra a sessão do usuário.
  Future<void> encerrarSessao() => _firebaseAuth.signOut();

  // Métodos de login (Google, e-mail/senha, Facebook) serão
  // implementados quando a funcionalidade de autenticação for
  // desenvolvida no MVP.
}
