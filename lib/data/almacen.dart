import '../models/moodboard.dart';

class Usuario {
  final String nombre;
  final String correo;
  final String clave;

  Usuario(this.nombre, this.correo, this.clave);
}

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

  static final List<Usuario> usuarios = [
    Usuario('franklin', 'franklin@sparkpoint.com', '123456'),
  ];

  static Usuario? usuarioActual;

  static bool usuarioExiste(String nombre, String correo) {
    return usuarios.any((u) =>
        u.nombre.toLowerCase() == nombre.toLowerCase() ||
        u.correo.toLowerCase() == correo.toLowerCase());
  }

  static void registrarUsuario(Usuario u) {
    usuarios.add(u);
  }

  /// Devuelve el usuario si las credenciales son correctas, o null.
  static Usuario? iniciarSesion(String identificador, String clave) {
    for (final Usuario u in usuarios) {
      final bool coincide =
          u.nombre.toLowerCase() == identificador.toLowerCase() ||
              u.correo.toLowerCase() == identificador.toLowerCase();
      if (coincide && u.clave == clave) {
        return u;
      }
    }
    return null;
  }

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