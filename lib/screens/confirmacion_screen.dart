import 'package:flutter/material.dart';
import '../models/moodboard.dart';
import '../theme/app_colors.dart';
import '../widgets/logo_spark.dart';
import 'main_shell.dart';

class ConfirmacionScreen extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final Moodboard moodboard;
  final bool mostrarCarpetas;

  const ConfirmacionScreen._({
    required this.titulo,
    required this.subtitulo,
    required this.moodboard,
    required this.mostrarCarpetas,
  });

  /// Confirmación de guardado.
  factory ConfirmacionScreen.guardado(
      {required Moodboard moodboard, required String carpeta}) {
    return ConfirmacionScreen._(
      titulo: '¡Propuesta guardada con éxito!',
      subtitulo: 'Guardado en la carpeta «$carpeta»',
      moodboard: moodboard,
      mostrarCarpetas: true,
    );
  }

  /// Confirmación de envío.
  factory ConfirmacionScreen.envio(
      {required Moodboard moodboard, required String destino}) {
    return ConfirmacionScreen._(
      titulo: '¡Moodboard enviado!',
      subtitulo: 'Enviado a $destino',
      moodboard: moodboard,
      mostrarCarpetas: false,
    );
  }

  void volverAlHome(BuildContext context, {int pestana = 0}) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => MainShell(pestanaInicial: pestana)),
      (ruta) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Moodboard m = moodboard;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              const LogoSpark(tamano: 80),
              const SizedBox(height: 24),
              Text(titulo,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text(subtitulo,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.superficie,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m.tema, style: Theme.of(context).textTheme.titleLarge),
                    Text('Estilo ${m.estilo.nombre}',
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        for (final c in m.paleta)
                          Expanded(
                            child: Container(
                              height: 36,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                color: c,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: AppColors.degradado,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () => volverAlHome(context),
                  icon: const Icon(Icons.home, color: Colors.black),
                  label: const Text('Volver al Home',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black)),
                ),
              ),
              if (mostrarCarpetas) ...[
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => volverAlHome(context, pestana: 2),
                    icon: const Icon(Icons.folder_open),
                    label: const Text('Ver en mis carpetas'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}