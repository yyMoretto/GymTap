// treino.dart
import 'package:isar/isar.dart';
import 'package:gymtap/nucleo/banco_local/sincronizavel.dart';
import 'package:gymtap/funcionalidades/treino/modelos/serie.dart';

part 'treino.g.dart';

/// Item da ficha: um exercício com suas séries planejadas.
/// Embutido dentro de Treino — referencia o Exercicio por id.
@embedded
class ItemTreino {
  late int exercicioId; // referência ao Exercicio (coleção própria)

  late String exercicioNomeCache; // cache do nome, evita join pra exibir na UI

  late List<Serie> series;
}

@collection
class Treino with Sincronizavel {
  Id id = Isar.autoIncrement;

  late String nome; // Ex: "Treino A"

  late List<ItemTreino> itens;

  @override
  late DateTime dataAtualizacao;

  @override
  late bool sincronizado;

  @override
  late bool removido;
}