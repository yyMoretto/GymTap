import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../nucleo/banco_local/isar_database.dart';
import '../modelos/exercicio.dart';
import '../modelos/treino.dart';

/// Repository da funcionalidade Treino.
///
/// Único ponto de acesso ao Isar para fichas de treino. Nenhuma tela
/// deve consultar ou escrever no banco diretamente — tudo passa por
/// aqui. Este Repository não conhece Firebase; a sincronização é
/// responsabilidade do SincronizacaoService, orquestrada depois.
class TreinoRepositorio {
  TreinoRepositorio({Isar? isar}) : _isar = isar ?? IsarDatabase.instancia;

  final Isar _isar;
  final _uuid = const Uuid();

  // ---------------------------------------------------------------------
  // Leitura
  // ---------------------------------------------------------------------

  /// Lista todas as fichas ativas (não removidas), ordenadas por [ordem].
  Future<List<Treino>> listarTreinos() {
    return _isar.treinos
        .filter()
        .removidoEqualTo(false)
        .sortByOrdem()
        .findAll();
  }

  /// Busca uma ficha pelo id local do Isar. Retorna null se não existir.
  Future<Treino?> obterTreinoPorId(Id id) {
    return _isar.treinos.get(id);
  }

  /// Stream reativa das fichas ativas — a UI observa isso diretamente
  /// (via provedor) e é atualizada automaticamente a cada alteração,
  /// sem precisar recarregar manualmente.
  Stream<List<Treino>> observarTreinos() {
    return _isar.treinos
        .filter()
        .removidoEqualTo(false)
        .sortByOrdem()
        .watch(fireImmediately: true);
  }

  // ---------------------------------------------------------------------
  // Escrita
  // ---------------------------------------------------------------------

  /// Cria uma nova ficha de treino.
  Future<Treino> criarTreino({
    required String nome,
    int ordem = 0,
    List<Exercicio> exercicios = const [],
  }) async {
    final agora = DateTime.now();

    final treino = Treino()
      ..idNuvem = _uuid.v4()
      ..nome = nome
      ..ordem = ordem
      ..exercicios = List<Exercicio>.from(exercicios)
      ..dataCriacao = agora
      ..dataAtualizacao = agora
      ..sincronizado = false
      ..removido = false;

    await _isar.writeTxn(() async {
      await _isar.treinos.put(treino);
    });

    return treino;
  }

  /// Atualiza uma ficha existente (nome, ordem, exercícios, etc).
  /// [treino] deve ser uma instância já carregada (com [Treino.id]
  /// válido) — normalmente obtida via [obterTreinoPorId].
  Future<void> atualizarTreino(Treino treino) async {
    _marcarComoAlterado(treino);

    await _isar.writeTxn(() async {
      await _isar.treinos.put(treino);
    });
  }

  /// Salva o resultado da execução de um treino (Modo Treino): grava as
  /// séries realizadas (repetições e carga) e atualiza a última carga
  /// utilizada de cada exercício, para exibição rápida na próxima vez.
  Future<void> salvarExecucaoTreino({
    required Id treinoId,
    required List<Exercicio> exerciciosExecutados,
  }) async {
    await _isar.writeTxn(() async {
      final treino = await _isar.treinos.get(treinoId);
      if (treino == null) return;

      treino.exercicios = exerciciosExecutados;
      for (final exercicio in treino.exercicios) {
        exercicio.ultimaCargaUtilizada =
            _ultimaCargaRegistrada(exercicio) ?? exercicio.ultimaCargaUtilizada;
      }

      _marcarComoAlterado(treino);
      await _isar.treinos.put(treino);
    });
  }

  /// Remove uma ficha (soft delete). O registro continua no Isar,
  /// apenas marcado como removido, para que a exclusão também seja
  /// propagada ao Firebase na próxima sincronização.
  Future<void> deletarTreino(Id id) async {
    await _isar.writeTxn(() async {
      final treino = await _isar.treinos.get(id);
      if (treino == null) return;

      treino.removido = true;
      _marcarComoAlterado(treino);
      await _isar.treinos.put(treino);
    });
  }

  // ---------------------------------------------------------------------
  // Auxiliares privados
  // ---------------------------------------------------------------------

  /// Atualiza os metadados obrigatórios de toda escrita: marca a ficha
  /// como pendente de sincronização e registra o momento da alteração
  /// (usado como critério de Last Write Wins).
  void _marcarComoAlterado(Treino treino) {
    treino.dataAtualizacao = DateTime.now();
    treino.sincronizado = false;
  }

  /// Retorna a última carga registrada entre as séries concluídas de
  /// um exercício (da mais recente para a mais antiga).
  double? _ultimaCargaRegistrada(Exercicio exercicio) {
    for (final serie in exercicio.series.reversed) {
      if (serie.cargaUtilizada != null) return serie.cargaUtilizada;
    }
    return null;
  }
}
