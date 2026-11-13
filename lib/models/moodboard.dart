import 'dart:math';
import 'package:flutter/material.dart';
import 'estilo.dart';

class Moodboard {
  final String tema;
  final Estilo estilo;
  final List<Color> paleta;
  final List<String> palabras;
  final String tipoTitulo;
  final String tipoTexto;
  final List<String> texturas;

  Moodboard({
    required this.tema,
    required this.estilo,
    required this.paleta,
    required this.palabras,
    required this.tipoTitulo,
    required this.tipoTexto,
    required this.texturas,
  });

  String hex(Color c) =>
      '#${c.toARGB32().toRadixString(16).substring(2).toUpperCase()}';

  /// Crea una propuesta según el estilo. Cada llamada da una variación.
  static Moodboard generar(String tema, Estilo estilo) {
    final Random azar = Random();

    final List<String> palabrasBase = _palabras[estilo.nombre] ?? ['Creativo'];
    final List<String> palabras = List.of(palabrasBase)..shuffle(azar);

    final List<String> titulos = _titulos[estilo.nombre] ?? ['Montserrat Bold'];
    final List<String> texturas = List.of(_texturas)..shuffle(azar);

    // La paleta parte de los colores del estilo y suma 3 tonos variados.
    final List<Color> paleta = [...estilo.colores];
    while (paleta.length < 5) {
      final Color base = estilo.colores[azar.nextInt(estilo.colores.length)];
      final HSLColor hsl = HSLColor.fromColor(base);
      final double claridad = (hsl.lightness + (azar.nextDouble() - 0.5) * 0.5)
          .clamp(0.15, 0.9);
      final double giro = (hsl.hue + azar.nextInt(60) - 30) % 360;
      paleta.add(hsl.withHue(giro).withLightness(claridad).toColor());
    }

    return Moodboard(
      tema: tema,
      estilo: estilo,
      paleta: paleta,
      palabras: palabras.take(5).toList(),
      tipoTitulo: titulos[azar.nextInt(titulos.length)],
      tipoTexto: 'Inter Medium',
      texturas: texturas.take(4).toList(),
    );
  }

  static const Map<String, List<String>> _palabras = {
    'Maximalista': ['Exceso', 'Capas', 'Color vivo', 'Patrones', 'Contraste', 'Abundancia'],
    'Minimalista': ['Espacio', 'Calma', 'Esencial', 'Limpio', 'Equilibrio', 'Orden'],
    'Retro': ['Calidez', 'Analógico', 'Nostalgia', 'Años 70', 'Grano', 'Vintage'],
    'Rústico': ['Natural', 'Madera', 'Artesanal', 'Tierra', 'Campo', 'Cálido'],
    'Moderno': ['Funcional', 'Geométrico', 'Sobrio', 'Urbano', 'Líneas', 'Vidrio'],
    'Pop': ['Energía', 'Color plano', 'Cómic', 'Divertido', 'Impacto', 'Juvenil'],
    'Futurista': ['Neón', 'Tecnología', 'Digital', 'Brillo', 'Velocidad', 'Holograma'],
    'Asiático': ['Armonía', 'Tinta', 'Bambú', 'Caligrafía', 'Serenidad', 'Equilibrio'],
    'Art Déco': ['Lujo', 'Simetría', 'Dorado', 'Geometría', 'Elegancia', 'Años 20'],
    'Gótico': ['Misterio', 'Sombra', 'Dramático', 'Catedral', 'Noche', 'Contraste'],
    'Cartoon': ['Divertido', 'Contorno', 'Expresivo', 'Animado', 'Color vivo', 'Juego'],
    'Psicodélico': ['Ondas', 'Fluido', 'Visión', 'Saturado', 'Hipnótico', 'Años 60'],
    'Brutalista': ['Crudo', 'Masivo', 'Cuadrícula', 'Contraste duro', 'Honesto', 'Concreto'],
  };

  static const Map<String, List<String>> _titulos = {
    'Maximalista': ['Playfair Display', 'Abril Fatface'],
    'Minimalista': ['Montserrat Light', 'Helvetica Neue'],
    'Retro': ['Cooper Black', 'Pacifico', 'Bebas Neue'],
    'Rústico': ['Rye', 'Amatic SC'],
    'Moderno': ['Poppins SemiBold', 'Raleway Bold'],
    'Pop': ['Bangers', 'Lilita One'],
    'Futurista': ['Orbitron', 'Exo 2 Bold'],
    'Asiático': ['Noto Serif JP', 'Shippori Mincho'],
    'Art Déco': ['Poiret One', 'Limelight'],
    'Gótico': ['UnifrakturCook', 'Cinzel'],
    'Cartoon': ['Fredoka One', 'Luckiest Guy'],
    'Psicodélico': ['Monoton', 'Shrikhand'],
    'Brutalista': ['Space Grotesk Bold', 'Archivo Black'],
  };

  static const List<String> _texturas = [
    'Papel kraft', 'Grano analógico', 'Madera', 'Concreto',
    'Lino', 'Terciopelo', 'Metal cepillado', 'Acuarela',
  ];
}