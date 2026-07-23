// exercicio.dart
import 'package:isar/isar.dart';
import 'package:gymtap/nucleo/banco_local/sincronizavel.dart';

part 'exercicio.g.dart';

/// Biblioteca de exercícios. Coleção própria para permitir reutilização
/// entre treinos e evolução futura (busca, favoritos, exercícios customizados).
@collection
class Exercicio with Sincronizavel {
  Id id = Isar.autoIncrement;

  late String nome; // Ex: "Supino Reto"

  String? grupoMuscular; // Ex: "Peito" (opcional no MVP)

  /// Último peso utilizado neste exercício, guardado aqui
  /// para consulta rápida sem precisar varrer o histórico.
  double? ultimaCargaUtilizada;

  @override
  late DateTime dataAtualizacao;

  @override
  late bool sincronizado;

  @override
  late bool removido;
}