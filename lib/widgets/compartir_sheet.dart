import 'package:flutter/material.dart';
import '../models/moodboard.dart';
import '../screens/confirmacion_screen.dart';
import '../theme/app_colors.dart';

/// Abre la hoja inferior de Compartir.
void mostrarCompartir(BuildContext contexto, Moodboard moodboard) {
  showModalBottomSheet(
    context: contexto,
    backgroundColor: AppColors.superficie,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) =>
        _CompartirSheet(contextoPadre: contexto, moodboard: moodboard),
  );
}

class _CompartirSheet extends StatefulWidget {
  final BuildContext contextoPadre;
  final Moodboard moodboard;

  const _CompartirSheet(
      {required this.contextoPadre, required this.moodboard});

  @override
  State<_CompartirSheet> createState() => _CompartirSheetState();
}

class _CompartirSheetState extends State<_CompartirSheet> {
  bool verUsuarios = false;
  String filtro = '';

  final List<String> usuarios = [
    '@carlos.design',
    '@laura_crossmedia',
    '@sofia.visual',
    '@andres_brand',
  ];

  /// Cierra la hoja y abre la confirmación de envío.
  void enviar(String destino) {
    Navigator.pop(context);
    Navigator.push(
      widget.contextoPadre,
      MaterialPageRoute(
        builder: (_) => ConfirmacionScreen.envio(
            moodboard: widget.moodboard, destino: destino),
      ),
    );
  }

  Widget opcion(IconData icono, String titulo, VoidCallback alTocar,
      {String? subtitulo}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.fondo,
        child: Icon(icono, color: AppColors.amarillo),
      ),
      title: Text(titulo),
      subtitle: subtitulo == null ? null : Text(subtitulo),
      trailing: const Icon(Icons.chevron_right),
      onTap: alTocar,
    );
  }

  Widget listaOpciones() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        opcion(Icons.download, 'Descargar imagen',
            () => enviar('tu dispositivo')),
        opcion(Icons.chat, 'WhatsApp', () => enviar('WhatsApp')),
        opcion(Icons.push_pin, 'Pinterest', () => enviar('Pinterest')),
        opcion(Icons.camera_alt, 'Instagram', () => enviar('Instagram')),
        opcion(Icons.group, 'Usuarios de Spark Point', () {
          setState(() {
            verUsuarios = true;
          });
        }, subtitulo: 'Compartir con otros diseñadores'),
      ],
    );
  }

  Widget listaUsuarios() {
    final List<String> resultados = usuarios
        .where((u) => u.toLowerCase().contains(filtro.toLowerCase()))
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          autofocus: true,
          onChanged: (texto) {
            setState(() {
              filtro = texto.trim();
            });
          },
          decoration: const InputDecoration(
            hintText: 'Buscar diseñador por @usuario...',
            prefixIcon: Icon(Icons.search, color: AppColors.textoSecundario),
          ),
        ),
        const SizedBox(height: 12),
        if (resultados.isEmpty)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('No se encontraron diseñadores.'),
          )
        else
          for (final String u in resultados)
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.fondo,
                child: Icon(Icons.person, color: AppColors.amarillo),
              ),
              title: Text(u, style: const TextStyle(color: AppColors.amarillo)),
              trailing: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.amarillo,
                  foregroundColor: Colors.black,
                ),
                onPressed: () => enviar(u),
                child: const Text('Enviar'),
              ),
            ),
        TextButton(
          onPressed: () {
            setState(() {
              verUsuarios = false;
              filtro = '';
            });
          },
          child: const Text('Volver a las opciones'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Compartir moodboard',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            if (verUsuarios) listaUsuarios() else listaOpciones(),
            if (!verUsuarios)
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}