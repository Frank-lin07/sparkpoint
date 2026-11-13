import 'package:flutter/material.dart';

class Estilo {
  final String nombre;
  final List<Color> colores;
  final IconData icono;

  const Estilo(this.nombre, this.colores, this.icono);
}

const List<Estilo> estilos = [
  Estilo('Maximalista', [Color(0xFFE91E63), Color(0xFFFF9800)], Icons.palette),
  Estilo('Minimalista', [Color(0xFFEEEEEE), Color(0xFF9E9E9E)], Icons.crop_square),
  Estilo('Retro', [Color(0xFFE07A2F), Color(0xFF5D3A1A)], Icons.radio),
  Estilo('Rústico', [Color(0xFF8D6E63), Color(0xFF4E342E)], Icons.forest),
  Estilo('Moderno', [Color(0xFF607D8B), Color(0xFF263238)], Icons.apartment),
  Estilo('Pop', [Color(0xFFFFEB3B), Color(0xFFE91E63)], Icons.bolt),
  Estilo('Futurista', [Color(0xFF00E5FF), Color(0xFF311B92)], Icons.rocket_launch),
  Estilo('Asiático', [Color(0xFFD32F2F), Color(0xFF212121)], Icons.temple_buddhist),
  Estilo('Art Déco', [Color(0xFFC9A227), Color(0xFF1A1A1A)], Icons.diamond),
  Estilo('Gótico', [Color(0xFF4A148C), Color(0xFF000000)], Icons.castle),
  Estilo('Cartoon', [Color(0xFF29B6F6), Color(0xFFFFEE58)], Icons.emoji_emotions),
  Estilo('Psicodélico', [Color(0xFF7C4DFF), Color(0xFFFF4081)], Icons.blur_on),
  Estilo('Brutalista', [Color(0xFF757575), Color(0xFF212121)], Icons.view_quilt),
];