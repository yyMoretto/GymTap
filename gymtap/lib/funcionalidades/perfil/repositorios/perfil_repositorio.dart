/// Repository da funcionalidade Perfil.
///
/// Único ponto de acesso a dados desta funcionalidade — orquestra o
/// Isar (leitura/escrita local) e, quando necessário, o service de
/// sincronização com o Firebase.
///
/// Nenhuma tela pode acessar Isar ou Firebase diretamente: tudo passa
/// por este Repository.
class PerfilRepositorio {
  PerfilRepositorio();

  // Métodos de leitura e escrita serão implementados junto com a
  // modelagem de dados (modelos/) desta funcionalidade.
}
