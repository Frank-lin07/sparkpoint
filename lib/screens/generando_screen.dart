import 'package:flutter/material.dart';
import '../models/estilo.dart';
import '../models/moodboard.dart';
import '../theme/app_colors.dart';
import '../widgets/logo_spark.dart';
import 'resultado_screen.dart';

class GenerandoScreen extends StatefulWidget {
  final String tema;
  final Estilo estilo;

  const GenerandoScreen({super.key, required this.tema, required this.estilo});

  @override
  State<GenerandoScreen> createState() => _GenerandoScreenState();
}

class _GenerandoScreenState extends State<GenerandoScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController pulso;

  @override
  void initState() {
    super.initState();
    pulso = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
      lowerBound: 0.85,
      upperBound: 1.1,
    )..repeat(reverse: true);

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      final Moodboard m = Moodboard.generar(widget.tema, widget.estilo);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ResultadoScreen(moodboard: m)),
      );
    });
  }

  @override
  void dispose() {
    pulso.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ScaleTransition(
                  scale: pulso,
                  child: const LogoSpark(tamano: 110),
                ),
                const SizedBox(height: 32),
                Text('Creando tu propuesta...',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text(
                  'Sintetizando paleta, tipografías y texturas para «${widget.tema}» en estilo ${widget.estilo.nombre}.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 28),
                const SizedBox(
                  width: 220,
                  child: LinearProgressIndicator(
                    color: AppColors.amarillo,
                    backgroundColor: AppColors.superficie,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}