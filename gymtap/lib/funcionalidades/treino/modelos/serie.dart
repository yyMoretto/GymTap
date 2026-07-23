// serie.dart
import 'package:isar/isar.dart';

part 'serie.g.dart';

/// Configuração de uma série planejada dentro de um Treino.
/// Objeto embutido: não existe fora do contexto de um Treino específico.
@embedded
class Serie {
  late int numeroSerie; // ordem dentro do exercício (1, 2, 3...)

  late int repeticoesAlvo;

  late int descansoSegundos;
}