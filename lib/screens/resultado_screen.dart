import 'package:flutter/material.dart';
import '../models/moodboard.dart';
import '../theme/app_colors.dart';
import 'generando_screen.dart';
import 'carpetas_screen.dart';
import '../widgets/compartir_sheet.dart';

class ResultadoScreen extends StatelessWidget {
  final Moodboard moodboard;

  const ResultadoScreen({super.key, required this.moodboard});

  Widget titulo(BuildContext context, IconData icono, String texto) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Row(
        children: [
          Icon(icono, color: AppColors.amarillo, size: 22),
          const SizedBox(width: 8),
          Text(texto, style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }

  void regenerar(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            GenerandoScreen(tema: moodboard.tema, estilo: moodboard.estilo),
      ),
    );
  }

  void proximamente(BuildContext context, String nombre) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$nombre: próximamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Moodboard m = moodboard;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.fondo,
        title: const Text('Detalle de moodboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Estilo ${m.estilo.nombre}'.toUpperCase(),
                style: const TextStyle(
                    color: AppColors.amarillo,
                    fontWeight: FontWeight.w700,
                    fontSize: 12)),
            const SizedBox(height: 6),
            Text(m.tema, style: Theme.of(context).textTheme.headlineMedium),

            titulo(context, Icons.palette_outlined, 'Armonía cromática'),
            Row(
              children: [
                for (final Color c in m.paleta)
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                            color: c,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(m.hex(c),
                            style: const TextStyle(
                                fontSize: 9, color: AppColors.textoSecundario)),
                      ],
                    ),
                  ),
              ],
            ),

            titulo(context, Icons.label_outline, 'Concepto y palabras clave'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final String p in m.palabras)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.superficie,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('# $p',
                        style: const TextStyle(
                            color: AppColors.amarillo,
                            fontWeight: FontWeight.w600)),
                  ),
              ],
            ),

            titulo(context, Icons.text_fields, 'Tipografías sugeridas'),
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
                  const Text('TÍTULO',
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textoSecundario)),
                  Text(m.tipoTitulo,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.naranja)),
                  const SizedBox(height: 14),
                  const Text('TEXTO',
                      style: TextStyle(
                          fontSize: 11, color: AppColors.textoSecundario)),
                  Text(m.tipoTexto,
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),

            titulo(context, Icons.grid_view, 'Texturas'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final String t in m.texturas)
                  Chip(
                    label: Text(t),
                    backgroundColor: AppColors.superficie,
                  ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              IconButton.filledTonal(
                onPressed: () => regenerar(context),
                icon: const Icon(Icons.refresh),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.degradado,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => CarpetasScreen(porGuardar: moodboard)),
                    ),
                    child: const Text('Guardar moodboard',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton.filledTonal(
                onPressed: () => mostrarCompartir(context, moodboard),
                icon: const Icon(Icons.share),
              ),
            ],
          ),
        ),
      ),
    );
  }
}