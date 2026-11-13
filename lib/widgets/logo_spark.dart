import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Dibuja una chispa de 4 puntas con degradado vertical amarillo-naranja.
class _ChispaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final double cx = w / 2;
    final double cy = h / 2;

    // d controla qué tan ancho es el centro de la chispa.
    final double d = w * 0.07;

    final Path path = Path()
      ..moveTo(cx, 0)
      ..quadraticBezierTo(cx + d, cy - d, w, cy)
      ..quadraticBezierTo(cx + d, cy + d, cx, h)
      ..quadraticBezierTo(cx - d, cy + d, 0, cy)
      ..quadraticBezierTo(cx - d, cy - d, cx, 0)
      ..close();

    final Paint pincel = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [AppColors.amarillo, AppColors.naranja],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawPath(path, pincel);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Una sola chispa, con el tamaño que le indiques.
class Chispa extends StatelessWidget {
  final double tamano;

  const Chispa({super.key, this.tamano = 40});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: tamano,
      height: tamano,
      child: CustomPaint(painter: _ChispaPainter()),
    );
  }
}

/// Logo: chispa grande al centro, una mediana arriba a la derecha
/// y una pequeña abajo a la izquierda.
class LogoSpark extends StatelessWidget {
  final double tamano;

  const LogoSpark({super.key, this.tamano = 80});

  @override
  Widget build(BuildContext context) {
    final double t = tamano;

    return SizedBox(
      width: t * 1.3,
      height: t * 1.3,
      child: Stack(
        children: [
          // Chispa pequeña abajo a la izquierda
          Positioned(
            left: t * 0.06,
            top: t * 0.8,
            child: Chispa(tamano: t * 0.4),
          ),
          // Chispa mediana arriba a la derecha
          Positioned(
            left: t * 0.765,
            top: 0,
            child: Chispa(tamano: t * 0.45),
          ),
          // Chispa grande central
          Positioned(
            left: t * 0.15,
            top: t * 0.15,
            child: Chispa(tamano: t),
          ),
        ],
      ),
    );
  }
}