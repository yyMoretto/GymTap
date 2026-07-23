import 'package:isar/isar.dart';
import 'package:gymtap/nucleo/banco_local/sincronizavel.dart';

part 'sessao_treino.g.dart';

/// Registro de uma série efetivamente realizada durante o treino.
/// Objeto embutido: não existe como coleção própria no Isar,
/// vive sempre dentro de uma SessaoTreino.
@embedded
class SerieRealizada {
  late String exercicioNome; // nome do exercício no momento da execução

  late int numeroSerie; // ex: 1, 2, 3...

  late int repeticoesRealizadas;

  late double cargaUtilizada; // em kg

  DateTime? horarioConclusao;
}

/// Registro imutável da execução de um treino.
/// Nunca é editado após criado — apenas lido para compor
/// o histórico e a evolução do usuário.
@collection
class SessaoTreino with Sincronizavel {
  Id id = Isar.autoIncrement;

  /// Referência ao Treino que originou esta sessão (id do Treino no Isar).
  late int treinoId;

  /// Nome do treino no momento da execução (ex: "Treino A"),
  /// guardado aqui para não depender de o Treino ainda existir.
  late String nomeTreino;

  late DateTime dataInicio;

  late DateTime dataFim;

  late List<SerieRealizada> series;

  /// Observações livres do usuário sobre a sessão (opcional).
  String? observacoes;

  @override
  late DateTime dataAtualizacao;

  @override
  late bool sincronizado;

  @override
  late bool removido;
}