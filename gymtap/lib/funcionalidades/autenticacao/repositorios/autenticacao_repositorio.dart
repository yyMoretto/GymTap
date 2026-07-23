import '../../../nucleo/services/autenticacao_service.dart';

/// Repository da funcionalidade Autenticação.
///
/// Orquestra o AutenticacaoService (Firebase Auth) e, futuramente, o
/// cache local do usuário logado no Isar. A UI nunca acessa o
/// AutenticacaoService diretamente — apenas através deste Repository.
class AutenticacaoRepositorio {
  AutenticacaoRepositorio({AutenticacaoService? autenticacaoService})
      : _autenticacaoService = autenticacaoService ?? AutenticacaoService();

  final AutenticacaoService _autenticacaoService;

  /// Emite `true`/`false` conforme o usuário está autenticado ou não.
  Stream<bool> observarStatusLogin() {
    return _autenticacaoService
        .observarUsuario()
        .map((usuario) => usuario != null);
  }

  // Métodos de login (Google, e-mail, Facebook) e logout serão
  // implementados junto com a funcionalidade de autenticação do MVP.
}
