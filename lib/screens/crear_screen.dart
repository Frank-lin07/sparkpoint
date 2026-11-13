import 'package:flutter/material.dart';
import '../models/estilo.dart';
import '../theme/app_colors.dart';

class CrearScreen extends StatefulWidget {
  final void Function(String tema, Estilo estilo) alGenerar;

  const CrearScreen({super.key, required this.alGenerar});

  @override
  State<CrearScreen> createState() => _CrearScreenState();
}

class _CrearScreenState extends State<CrearScreen> {
  final TextEditingController temaCtrl = TextEditingController();
  Estilo seleccionado = estilos[2]; // Retro por defecto

  // Los 2 primeros fijos; el 3er lugar lo ocupa el estilo elegido.
  final List<Estilo> fijos = [estilos[0], estilos[1]];

  @override
  void dispose() {
    temaCtrl.dispose();
    super.dispose();
  }

  Widget tarjetaEstilo(Estilo e, {double alto = 110, bool compacta = false}) {
    final bool activo = e == seleccionado;
    return GestureDetector(
      onTap: () {
        setState(() {
          seleccionado = e;
        });
        if (compacta) Navigator.pop(context);
      },
      child: Container(
        height: alto,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: e.colores,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: activo ? AppColors.amarillo : Colors.transparent,
            width: 3,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                e.icono,
                size: compacta ? 26 : 36,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
            Positioned(
              left: 8,
              bottom: 8,
              right: 8,
              child: Text(
                e.nombre,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: compacta ? 11 : 14,
                  color: Colors.white,
                ),
              ),
            ),
            if (activo)
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.amarillo,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget tarjetaVerMas() {
    return GestureDetector(
      onTap: abrirTodos,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: AppColors.superficie,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.amarillo.withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.apps, color: AppColors.amarillo, size: 32),
            const SizedBox(height: 6),
            Text(
              'Ver ${estilos.length - 3} más',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.amarillo,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void abrirTodos() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.superficie,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        final resto = estilos.where((e) => !fijos.contains(e)).toList();
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Todos los estilos',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                itemCount: resto.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 80,
                ),
                itemBuilder: (_, i) =>
                    tarjetaEstilo(resto[i], alto: 80, compacta: true),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void generar() {
    final String tema = temaCtrl.text.trim();
    if (tema.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escribe el tema del proyecto.')),
      );
      return;
    }
    widget.alGenerar(tema, seleccionado);
  }

  @override
  Widget build(BuildContext context) {
    // Vista previa: 2 fijos + el 3er lugar es el elegido si no es fijo.
    final Estilo tercero =
        fijos.contains(seleccionado) ? estilos[2] : seleccionado;

    return SafeArea(
      child: SingleChildScrollView( // <-- ¡Aquí está la solución agregada!
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nuevo Moodboard',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            Text('Tema del proyecto',
                style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            TextField(
              controller: temaCtrl,
              decoration: const InputDecoration(
                hintText: 'Ej: campaña para una cafetería juvenil',
                prefixIcon: Icon(Icons.lightbulb_outline,
                    color: AppColors.textoSecundario),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Elige un estilo visual',
                    style: Theme.of(context).textTheme.titleLarge),
                Text(
                  '${estilos.length} estilos',
                  style: const TextStyle(
                      color: AppColors.amarillo, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.35,
              children: [
                tarjetaEstilo(fijos[0]),
                tarjetaEstilo(fijos[1]),
                tarjetaEstilo(tercero),
                tarjetaVerMas(),
              ],
            ),
            const SizedBox(height: 32), // <-- Cambiamos el Spacer por espacio fijo con scroll
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
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: generar,
                child: const Text(
                  'Generar moodboard',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}