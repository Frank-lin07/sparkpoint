import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static const String fuenteTitulos = 'Montserrat';
  static const String fuenteTextos = 'Inter';

  static ThemeData get oscuro {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.fondo,
      fontFamily: fuenteTextos,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.amarillo,
        secondary: AppColors.naranja,
        surface: AppColors.superficie,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: fuenteTitulos,
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: AppColors.textoPrincipal,
        ),
        headlineMedium: TextStyle(
          fontFamily: fuenteTitulos,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.textoPrincipal,
        ),
        titleLarge: TextStyle(
          fontFamily: fuenteTitulos,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textoPrincipal,
        ),
        bodyLarge: TextStyle(
          fontFamily: fuenteTextos,
          fontSize: 16,
          color: AppColors.textoPrincipal,
        ),
        bodyMedium: TextStyle(
          fontFamily: fuenteTextos,
          fontSize: 14,
          color: AppColors.textoSecundario,
        ),
        labelLarge: TextStyle(
          fontFamily: fuenteTextos,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.textoPrincipal,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.superficie,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}