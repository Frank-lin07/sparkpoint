import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/logo_spark.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback alCrear;

  const HomeScreen({super.key, required this.alCrear});

  Widget tarjetaProyecto(
      BuildContext context, String titulo, String cantidad, String hora,
      List<Color> colores) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.superficie,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: colores),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 10),
          Text(titulo,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 4),
          Text('$cantidad moodboards',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 4),
          Text(hora,
              style: const TextStyle(
                  fontSize: 12, color: AppColors.textoSecundario)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final proyectos = [
      ['Cafetería juvenil', '3', 'Hace 2h',
        [const Color(0xFFE07A2F), const Color(0xFF2D1B0E)]],
      ['Novedad Cyberwear', '5', 'Ayer',
        [const Color(0xFF00E5FF), const Color(0xFF3D1A78)]],
      ['Packaging Orgánico', '2', 'Hace 3d',
        [const Color(0xFF8FA58B), const Color(0xFF2E3B2C)]],
      ['Festival Sonora', '4', 'Hace 1 sem',
        [const Color(0xFFE91E63), const Color(0xFF311B92)]],
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const LogoSpark(tamano: 28),
                const SizedBox(width: 8),
                Text('Spark Point',
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 24),
            Text('¡Hola, Franklin!',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 4),
            Text('¿Qué idea vamos a encender hoy?',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.superficie,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nuevo Moodboard',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(
                    'Transforma tu concepto Crossmedia en segundos con dirección de arte instantánea.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppColors.degradado,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: alCrear,
                      child: const Text(
                        'Comenzar creación',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text('Proyectos recientes',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: proyectos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 190,
              ),
              itemBuilder: (context, i) {
                final p = proyectos[i];
                return tarjetaProyecto(context, p[0] as String,
                    p[1] as String, p[2] as String, p[3] as List<Color>);
              },
            ),
          ],
        ),
      ),
    );
  }
}