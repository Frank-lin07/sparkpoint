# Spark Point

**Tu punto de partida creativo.**

Aplicación móvil hecha en Flutter para diseñadores y estudiantes de
Crossmedia. A partir de un tema y un estilo visual, genera un moodboard
base que se puede guardar en carpetas por proyecto y compartir.

**Estudiante:** Franklin Grisales Castrillón
**Materia:** Lenguaje de Programación para APPs – UCC
**Momento:** Evaluativo 2 (avance del proyecto integrador)

## Problema

Al iniciar un proyecto, el diseñador pierde mucho tiempo buscando
inspiración, paletas, tipografías y palabras clave, lo que retrasa el
arranque y genera propuestas poco definidas.

## Objetivo

Ofrecer una herramienta que genere un moodboard base a partir de un tema
y un estilo, y que permita guardarlo y compartirlo para trabajar con él.

## Diseño

El prototipo de alta fidelidad se hizo en Figma (Proceso Apps):
(https://www.figma.com/design/KR9FMCJit22rtqfAtdTztt/SparkPoint-Momento-2?node-id=0-1&t=cVAY8VV3Qh43cSDD-1)

## Instalación y ejecución

Requisitos: Flutter instalado y Google Chrome.

```
flutter pub get
flutter run -d chrome
```

Las fuentes (Montserrat e Inter) están dentro del proyecto, en
`assets/fonts`, así que no se necesita internet para verlas.

**Cuenta de demostración** (los datos viven en memoria): usuario
`franklin`, contraseña `123456`. También se puede crear una cuenta nueva
desde "Registrarse".

## Funcionalidades e inventario

| # | Funcionalidad | Estado | Evidencia |
|---|---|---|---|
| 1 | Registro e inicio de sesión con validaciones | Completa | Pantalla de login/registro; valida campos vacíos, correo, longitud y contraseñas iguales |
| 2 | Generar moodboard (tema + 13 estilos) | Completa | Pantallas Crear, Generando y Resultado |
| 3 | Generar otra propuesta (variación) | Completa | Botón ↻ en Resultado: mismo tema y estilo, paleta y palabras distintas |
| 4 | Guardar en carpetas por proyecto | Completa | Pantalla Carpetas: crear, elegir carpeta y guardar, con confirmación |
| 5 | Compartir (5 opciones) | Completa (envío simulado) | Hoja de Compartir y confirmación de envío |
| 6 | Buscar proyectos y carpetas | Completa | Buscador en Carpetas: por nombre, tema o estilo |

**Avance: 6 de 6 funcionalidades planificadas (100 %).**

Funciones no disponibles todavía (están identificadas en la app):
- Pestaña **Perfil**: muestra "próximamente".
- Compartir con WhatsApp, Pinterest, Instagram y descargar es una
  **simulación**: muestra la confirmación, pero no envía nada real.
- Los datos se guardan **solo en memoria**: al cerrar la app se pierden.
- Las imágenes guía y texturas se representan con colores, degradados e
  íconos; no hay fotos reales.

## Estructura del proyecto

```
lib/
├── main.dart                  Arranque de la app y tema
├── theme/
│   ├── app_colors.dart        Design System: colores y degradado
│   └── app_theme.dart         ThemeData, TextTheme y tipografías
├── models/
│   ├── estilo.dart            Clase Estilo y lista de los 13 estilos
│   └── moodboard.dart         Clase Moodboard y generador por estilo
├── data/
│   └── almacen.dart           Usuarios y carpetas en memoria
├── screens/
│   ├── login_screen.dart      Inicio de sesión y registro
│   ├── main_shell.dart        Barra de navegación inferior
│   ├── home_screen.dart       Inicio con proyectos recientes
│   ├── crear_screen.dart      Tema y selector de estilos
│   ├── generando_screen.dart  Pantalla de carga animada
│   ├── resultado_screen.dart  Moodboard generado
│   ├── carpetas_screen.dart   Carpetas, guardado y búsqueda
│   └── confirmacion_screen.dart  Confirmación de guardado y de envío
└── widgets/
    ├── logo_spark.dart        Logo de tres chispas (CustomPainter)
    └── compartir_sheet.dart   Hoja inferior de Compartir
```

## Design System

- **Colores** centralizados en `AppColors`: fondo negro `#0D0D0D`,
  superficie `#1A1A1A`, amarillo `#FFC107`, naranja `#FF7A00`, ámbar
  `#FFD98A` y degradado amarillo-naranja para los botones principales.
- **Tipografías:** Montserrat para títulos e Inter para textos,
  definidas en `AppTheme` con `ThemeData` y `TextTheme`.

## Navegación

Login → Home (barra inferior: Inicio, Crear, Carpetas, Perfil).
Crear → Generando → Resultado. Desde Resultado: regenerar (vuelve a
Generando), Guardar (Carpetas → Confirmación) o Compartir (hoja →
Confirmación). La confirmación vuelve al Home.

## Lógica principal

- **Generador:** `Moodboard.generar` toma el estilo, baraja palabras
  clave y texturas con `Random` y crea tonos nuevos a partir de los
  colores del estilo, por eso cada regeneración es distinta.
- **Estructuras de datos:** `List` (estilos, carpetas, usuarios, paleta),
  `Map` (palabras clave y tipografías por estilo).
- **Almacén:** `Almacen` guarda usuarios y carpetas en memoria con
  métodos estáticos.
- **Validaciones:** campos vacíos, formato de correo, longitud mínima,
  contraseñas iguales, usuario o carpeta repetidos.

## Plan para el Momento 3

1. Guardar los datos de forma persistente (que no se pierdan al cerrar).
2. Pantalla de Perfil y cierre de sesión.
3. Compartir de forma real (descargar la imagen del moodboard).
4. Agregar imágenes guía reales a los moodboards.
5. Editar y eliminar moodboards guardados.
6. Pulir diseño y probar en un dispositivo.