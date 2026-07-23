import 'package:flutter/material.dart';

import '../../nucleo/utilitarios/constantes.dart';

/// Tema visual global do GymTap: interface escura, limpa e sem
/// distrações, alinhada à identidade definida no projeto.
class AppTema {
  AppTema._();

  static ThemeData get escuro {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppCores.fundo,
      colorScheme: const ColorScheme.dark(
        surface: AppCores.cards,
        primary: AppCores.destaque,
        onPrimary: AppCores.textoPrincipal,
        onSurface: AppCores.textoPrincipal,
      ),
      cardColor: AppCores.cards,
      dividerColor: AppCores.bordas,
      fontFamily: 'Inter',
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppCores.textoPrincipal),
        bodyMedium: TextStyle(color: AppCores.textoSecundario),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppCores.fundo,
        foregroundColor: AppCores.textoPrincipal,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: AppCores.cards,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppCores.bordas),
        ),
      ),
    );
  }
}
