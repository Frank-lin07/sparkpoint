import '../models/moodboard.dart';

class Carpeta {
  final String nombre;
  final List<Moodboard> moodboards;

  Carpeta(this.nombre, [List<Moodboard>? iniciales])
      : moodboards = iniciales ?? [];
}

/// Almacén en memoria: lista de carpetas por proyecto.
class Almacen {
  static final List<Carpeta> carpetas = [
    Carpeta('Cafetería juvenil'),
    Carpeta('Packaging Orgánico'),
  ];

  static void crearCarpeta(String nombre) {
    carpetas.add(Carpeta(nombre));
  }

  static bool existe(String nombre) {
    return carpetas
        .any((c) => c.nombre.toLowerCase() == nombre.toLowerCase());
  }

  static void guardar(Moodboard m, Carpeta destino) {
    destino.moodboards.add(m);
  }
}