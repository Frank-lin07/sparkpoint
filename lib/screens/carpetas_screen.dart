import 'package:flutter/material.dart';
import '../data/almacen.dart';
import '../models/moodboard.dart';
import '../theme/app_colors.dart';
import 'confirmacion_screen.dart';

class CarpetasScreen extends StatefulWidget {
  /// Si viene un moodboard, la pantalla funciona en modo "guardar".
  final Moodboard? porGuardar;

  const CarpetasScreen({super.key, this.porGuardar});

  @override
  State<CarpetasScreen> createState() => _CarpetasScreenState();
}

class _CarpetasScreenState extends State<CarpetasScreen> {
  Carpeta? elegida;

  Future<void> nuevaCarpeta() async {
    final TextEditingController ctrl = TextEditingController();
    final String? nombre = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.superficie,
        title: const Text('Crear carpeta nueva'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Nombre del proyecto'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ctrl.text.trim()),
            child: const Text('Crear'),
          ),
        ],
      ),
    );

    if (nombre == null) return;
    if (!mounted) return;

    if (nombre.isEmpty) {
      mensaje('El nombre no puede estar vacío.');
      return;
    }
    if (Almacen.existe(nombre)) {
      mensaje('Ya existe una carpeta con ese nombre.');
      return;
    }

    setState(() {
      Almacen.crearCarpeta(nombre);
      elegida = Almacen.carpetas.last;
    });
  }

  void mensaje(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  void guardarAqui() {
    final Carpeta? destino = elegida;
    final Moodboard? m = widget.porGuardar;

    if (destino == null || m == null) {
      mensaje('Elige una carpeta primero.');
      return;
    }

    Almacen.guardar(m, destino);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ConfirmacionScreen.guardado(
            moodboard: m, carpeta: destino.nombre),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool modoGuardar = widget.porGuardar != null;

    return Scaffold(
      appBar: modoGuardar
          ? AppBar(backgroundColor: AppColors.fondo, title: const Text('Guardar'))
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (modoGuardar)
                const Text('DESTINO DE GUARDADO',
                    style: TextStyle(
                        color: AppColors.amarillo,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
              Text('Carpetas de proyectos',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 6),
              Text(
                modoGuardar
                    ? 'Selecciona el proyecto donde organizarás este moodboard.'
                    : 'Tus proyectos y los moodboards guardados.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: nuevaCarpeta,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.superficie,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.add, color: AppColors.amarillo),
                      SizedBox(width: 12),
                      Text('Crear carpeta nueva',
                          style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: Almacen.carpetas.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    final Carpeta c = Almacen.carpetas[i];
                    final bool activa = c == elegida;
                    return GestureDetector(
                      onTap: modoGuardar
                          ? () => setState(() => elegida = c)
                          : null,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.superficie,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: activa
                                ? AppColors.amarillo
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.folder,
                                color: activa
                                    ? AppColors.amarillo
                                    : AppColors.textoSecundario),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(c.nombre,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge),
                                  Text('${c.moodboards.length} moodboards',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ],
                              ),
                            ),
                            if (activa)
                              const Icon(Icons.check_circle,
                                  color: AppColors.amarillo),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (modoGuardar)
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
                    onPressed: guardarAqui,
                    child: const Text('Guardar aquí',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}