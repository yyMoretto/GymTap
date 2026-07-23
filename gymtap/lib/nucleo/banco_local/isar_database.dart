import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../funcionalidades/treino/modelos/treino.dart';

/// Ponto único de inicialização e acesso ao banco local (Isar).
///
/// Nenhuma tela ou service pode acessar o Isar diretamente — o acesso
/// é sempre feito através dos Repositories de cada funcionalidade.
class IsarDatabase {
  IsarDatabase._();

  static Isar? _instancia;

  /// Instância ativa do Isar. Lança erro se usada antes de [inicializarIsar].
  static Isar get instancia {
    final isar = _instancia;
    if (isar == null) {
      throw Exception(
        'Isar não foi inicializado. Chame inicializarIsar() no main.dart '
        'antes de rodar o app.',
      );
    }
    return isar;
  }

  static void _definirInstancia(Isar isar) => _instancia = isar;
}

/// Inicializa o banco local. Deve ser chamado uma única vez, antes de
/// qualquer Repository ser utilizado (tipicamente no main.dart).
///
/// Os schemas (coleções) de cada funcionalidade devem ser adicionados
/// aqui conforme forem criados, por exemplo:
///   [TreinoSchema, HistoricoSchema, ...]
Future<void> inicializarIsar() async {
  final diretorio = await getApplicationDocumentsDirectory();

  final isar = await Isar.open(
    [
      TreinoSchema,
      // Adicionar aqui os schemas das próximas funcionalidades:
      // HistoricoSchema,
    ],
    directory: diretorio.path,
    inspector: false,
  );

  IsarDatabase._definirInstancia(isar);
}
