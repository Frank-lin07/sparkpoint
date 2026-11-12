import 'package:flutter/material.dart';

class AppColors {
  // Fondos
  static const Color fondo = Color(0xFF0D0D0D);
  static const Color superficie = Color(0xFF1A1A1A);

  // Complementos
  static const Color amarillo = Color(0xFFFFC107);
  static const Color naranja = Color(0xFFFF7A00);
  static const Color ambar = Color(0xFFFFD98A);

  // Textos
  static const Color textoPrincipal = Color(0xFFF5F5F5);
  static const Color textoSecundario = Color(0xFFA8A8A8);

  // Degradado de los botones primarios
  static const LinearGradient degradado = LinearGradient(
    colors: [amarillo, naranja],
  );
}