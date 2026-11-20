#casa nativa
# Casa Nativa

Landing page responsive de una casa de hospedaje rural. Taller de Frameworks CSS
de Aplicaciones móviles y web (UCC). Estudiante: Franklin Grisales Castrillón.

Secciones: header, hero, servicios, reserva/contacto y footer.

## Framework asignado

- **Framework:** Materialize CSS 1.0.0
- **Instalación utilizada:** por CDN (cdnjs), con `<link>` al CSS y `<script>` al JS en `index.html`.

**Tres características que resultaron útiles**
1. Sistema de grilla de 12 columnas (`row`, `col s12 m6 l3`) que reacomoda las secciones en móvil y escritorio.
2. Componentes con comportamiento incluido (sidenav, datepicker y select) inicializados con `M.*`.
3. Efecto ripple (`waves-effect`) y helpers como `hide-on-med-and-down`, `center-align` y `valign-wrapper`.

**Tres componentes o utilidades usados**
1. `navbar` con `sidenav` para el menú móvil.
2. `card` para cada servicio.
3. Formulario con `input-field`, `datepicker`, `select` y `materialize-textarea`.

## Anime.js

- Menú: el logo y los enlaces entran con desplazamiento y aparición escalonada.
- Servicios: las cards entran con stagger al llegar a la sección y se elevan al pasar el mouse.

## Ejecución

Sitio estático: abrir `index.html` o usar Live Server en VS Code.

## Notas

- El formulario no tiene backend: valida en el navegador y muestra una confirmación.
- El elemento visual del hero es una composición con CSS e íconos, no una fotografía.