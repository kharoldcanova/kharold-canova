# DESIGN.md - Sistema de Diseño Universal

> Este documento define la fuente de la verdad para la interfaz de usuario (UI) y experiencia de usuario (UX) del proyecto. 
> **Instrucción para la IA:** Respeta estrictamente estos tokens, convenciones y reglas en cualquier código generado (Flutter, React, Tailwind, CSS nativo, etc.). No inventes colores, fuentes ni estilos fuera de este sistema.

---

## 1. Visión y Filosofía del Producto
* **Propósito:** Portafolio personal en Flutter Web que presenta el perfil, los conocimientos, los proyectos, las certificaciones y los canales de contacto de un desarrollador Full Stack enfocado en Flutter, Laravel, IA aplicada y automatización.
* **Estética Core:** Minimalista y silencioso, con una sola tarea en pantalla.
* **Principios de UX:**
  * **Claridad sobre ornamentación:** La información jerárquica debe leerse en menos de 3 segundos.
  * **Feedback inmediato:** Toda acción del usuario debe tener respuesta visual instantánea (estados hover, active, loading).
  * **Accesibilidad:** Alto contraste, tamaños táctiles adecuados y soporte para navegación por teclado/screen readers.

---

## 2. Design Tokens (La Fundación)

### 2.1. Paleta de Colores
Utiliza nombres semánticos en lugar de valores absolutos en el código.

| Token Semántico | Valor Hex / Light | Valor Hex / Dark | Uso Principal |
| :--- | :--- | :--- | :--- |
| `--bg-base` | `#FFFFFF` | `#000000` | Fondo principal de la aplicación |
| `--bg-surface` | `#FFFFFF` | `#121212` | Tarjetas, contenedores, paneles |
| `--bg-elevated` | `#ededed` | `#1C1C1C` | Modales, dropdowns, elementos flotantes |
| `--text-primary` | `#000000` | `#f2f4f7` | Títulos y texto principal |
| `--text-secondary` | `#3F3F46` | `#aaabad` | Subtítulos, metadatos, iconos inactivos |
| `--primary` | `#0033CC` | `#4ADE80` | Botones de acción principal, enlaces, estados activos |
| `--terminal-cyan` | — | `#56D4DD` | Información y enlaces secundarios del terminal oscuro |
| `--terminal-yellow` | — | `#E3C667` | Comandos y metadatos destacados del terminal oscuro |
| `--terminal-magenta` | — | `#D2A8FF` | Etiquetas y acentos secundarios del terminal oscuro |
| `--contact-dark` | — | `#166534` | Fondo de la sección de contacto en el modo oscuro |
| `--accent` | `#B00020` | `#b50f2d` | Elementos destacados, highlights, modo especial |
| `--success` | `#166534` | `#4ADE80` | Mensajes de éxito, estados online, confirmaciones |
| `--warning` | `#92400E` | `#FACC15` | Alertas, advertencias |
| `--error` | `#B91C1C` | `#F87171` | Errores, acciones destructivas |
| `--on-primary` | `#FFFFFF` | `#052E16` | Texto e iconos sobre `--primary` |
| `--border` | `#111111` | `#264A33` | Bordes, separadores, líneas divisorias |
| `--border-subtle` | `#111111` @ 40% | `#264A33` @ 40% | Divisores internos y metadatos |
| `--on-image` | `#FFFFFF` | `#FFFFFF` | Texto e iconos sobre imagen |
| `--on-image-muted` | `#FFFFFF` @ 82% | `#FFFFFF` @ 82% | Texto secundario sobre imagen |
| `--on-image-border` | `#FFFFFF` @ 40% | `#FFFFFF` @ 40% | Bordes de controles sobre imagen |
| `--hero-scrim` | Ninguno | Ninguno | El wallpaper claro conserva su brillo original; el tema oscuro no carga imagen |
| `--nav-surface` | `#FFFFFF` @ 92% | `#000000` @ 92% | Fondo del header tras hacer scroll |
| `--focus-ring` | `#0033CC` | `#4ADE80` | Anillo de foco de accesibilidad |
| `--content-max` | `1200px` | `1200px` | Ancho máximo del grid de contenido |

### 2.2. Tipografía
* **Modo claro:** `Poppins`, `Geist`, `Roboto`, system-ui, sans-serif.
* **Modo oscuro terminal:** `JetBrains Mono`, `Fira Code`, monospace para toda la interfaz.

| Estilo | Tamaño (Desktop) | Tamaño (Mobile) | Peso (Font Weight) | Line Height |
| :--- | :--- | :--- | :--- | :--- |
| **Hero Display** | 80px (5rem) | 36px (2.25rem) | Medium (500) | 1.0 |
| **Hero Role** | 38px (2.375rem) | 20px (1.25rem) | Regular (400) | 1.1 |
| **Heading 1** | 32px (2rem) | 24px (1.5rem) | Bold (700) | 1.2 |
| **Heading 2** | 24px (1.5rem) | 20px (1.25rem) | SemiBold (600) | 1.3 |
| **Heading 3** | 18px (1.125rem) | 16px (1rem) | SemiBold (600) | 1.4 |
| **Body Large** | 16px (1rem) | 15px (0.9375rem)| Regular (400) | 1.5 |
| **Body Regular** | 14px (0.875rem)| 14px (0.875rem)| Regular (400) | 1.5 |
| **Caption / Small**| 12px (0.75rem) | 12px (0.75rem) | Medium (500) | 1.4 |

### 2.3. Espaciado y Dimensiones (Grid de 4px / 8px)
* `xs`: 4px (`0.25rem`)
* `sm`: 8px (`0.5rem`)
* `md`: 16px (`1rem`)
* `lg`: 24px (`1.5rem`)
* `xl`: 32px (`2rem`)
* `2xl`: 48px (`3rem`)

### 2.4. Bordes y Radios (Border Radius)
* `radius-sm`: 0px (Elementos internos pequeños, tags)
* `radius-md`: 10px (Botones, inputs, controles interactivos)
* `radius-lg`: 16px (Tarjetas, paneles, modales y contenedores grandes)
* `radius-full`: 9999px (Avatares, botones circulares, pills)

### 2.5. Layout, Imagen y Navegación
* **Grid de contenido:** ancho máximo `--content-max` (1200px), centrado, con gutters de 80px en desktop y 24px en mobile.
* **Hero:** altura acotada al 68% del viewport en mobile (mín. 500px, máx. 600px) y al 72% en desktop (mín. 540px, máx. 700px). La identidad va abajo-izquierda en desktop y centrada-izquierda en mobile. El nombre usa `Hero Display` y el rol `Hero Role`; esta es la única excepción a la escala tipográfica estándar.
* **Scrim:** cuatro paradas con negro al 80% para mantener el contraste del texto también en el crop móvil brillante. Sin parallax ni sombras.
* **Header:** transparente sobre el hero; tras hacer scroll usa `--nav-surface` y un borde inferior de 1px.
* **Indicador activo:** subrayado de 2px en `--primary`, sin pills ni fondos rellenos.
* **Foco:** anillo visible con `--focus-ring`; sobre imagen se usa `--on-image` para mantener el contraste.
* **Contacto:** fondo dominante `--primary` (azul en claro, verde en oscuro) con texto e iconos `--on-primary`; el footer conserva `--bg-surface` y su borde superior.

---

## 3. Componentes Base y Estados Obligatorios

Cualquier componente interactivo **debe** contemplar los siguientes estados visuales:
1. **Default:** Estado base del componente.
2. **Hover:** Al pasar el cursor por encima (cambio sutil de tono o elevación).
3. **Active / Pressed:** Al hacer clic o tocar.
4. **Focus:** Indicador de accesibilidad visible (outline o anillo de enfoque usando `--primary`).
5. **Disabled:** Opacidad reducida (`0.5`), cursor `not-allowed`, sin eventos.
6. **Loading (Opcional):** Sustitución de contenido por skeleton o spinner manteniendo dimensiones.

### 3.1. Botones
* **Primary:** Fondo `--primary`, texto blanco/oscuro según contraste, radio `radius-md`.
* **Secondary / Outline:** Fondo transparente, borde `--border`, texto `--text-primary`.
* **Ghost:** Sin fondo ni borde, texto `--text-secondary`, adquiere fondo sutil en hover.

### 3.2. Hero con Imagen
* En modo claro, la imagen ocupa el hero completo con `BoxFit.cover`; no se usa retrato ni avatar.
* En modo oscuro, el hero no carga imágenes: usa un fondo negro sólido.
* La imagen de fondo nunca cambia de brillo o apariencia al pasar el cursor.
* En modo oscuro, el nombre y subtítulo del hero usan `JetBrains Mono`.
* En modo oscuro, se muestra una landing terminal separada: ventana `kharold@portfolio:~`, prompt `whoami`, pestañas navegables y scanlines muy tenues.
* La barra de navegación del terminal usa `JetBrains Mono`; el cursor respeta `disableAnimations`.
* El wallpaper se muestra a brillo original, sin scrim ni tratamiento de hover; el texto conserva contraste por ubicación, tipografía y controles.
* Experiencia, proyectos y certificaciones se localizan según el idioma activo; los enlaces sociales usan tarjetas terminales uniformes en columnas responsivas.
* El resumen de foco profesional aparece como `Desarrollo Full Stack · IA Aplicada` / `Full Stack Development · Applied AI`.
* La acción principal usa `--primary` con `--on-primary`; la secundaria es outline con `--on-image-border` y `--on-image`.
* El CV se abre en una pestaña nueva.

### 3.3. Navegación
* Cinco destinos: `Inicio`, `Sobre mí`, `Proyectos`, `Certificaciones`, `Contacto`.
* El header es transparente sobre el hero y pasa a `--nav-surface` con borde inferior al hacer scroll.
* El estado activo se indica con un subrayado de 2px, nunca con una pill rellena.
* El drawer replica todos los destinos y acciones; cierra al seleccionar y con `Escape`, devolviendo el foco al control de menú.

### 3.4. Formularios e Inputs
* Altura estándar: `40px` (Desktop) / `44px` (Mobile touch target).
* Fondo: `--bg-surface`.
* Borde: `--border`. En foco cambia a `--primary`.
* Mensaje de error: Texto en `--error` situado exactamente debajo del input con margen `xs`.

### 3.5. Sección de Contacto
* En modo claro: fondo dominante `--primary` y texto `--on-primary`.
* En modo oscuro: fondo verde oscuro `#166534` y texto blanco, con la tipografía terminal del tema.
* Tarjetas de contacto transparentes con borde de 1px; el hover y el foco solo cambian el borde, nunca oscurecen imágenes.
* El footer no se invierte: conserva `--bg-surface` con su borde superior de 1px.

### 3.6. Experiencia y Stack Técnico
* La experiencia profesional vive dentro de `Sobre mí` como una línea de tiempo: periodo en mono, rol como título, empresa y ubicación, y viñetas de impacto.
* El stack técnico reemplaza el radar por tarjetas agrupadas por área (`IA & MCP`, `DevOps & Cloud`, `Frontend & Móvil`, `Backend & Datos`).
* Cada grupo muestra tecnologías como chips; no se usan niveles numéricos, porcentajes ni gráficos de radar.
* En desktop los grupos van en dos columnas; en mobile, en una sola columna.

---

## 4. Guías de Implementación para la IA

* **Regla 1 (Cero Hardcoding):** Nunca utilices colores en hexadecimal directos (ej. `#3B82F6`) en los componentes de UI. Utiliza siempre las variables semánticas o tokens definidos en la sección 2.
* **Regla 2 (Consistencia Responsive):** Prioriza un enfoque *mobile-first*. Los contenedores principales deben adaptarse fluidamente usando Flexbox o Grid.
* **Regla 3 (Naming Conventions):** Mantén coherencia en los nombres de clases o widgets según el framework del proyecto (ej. camelCase para Flutter, kebab-case para CSS/Tailwind).
* **Regla 4 (Feedback de Cambios):** Si se añade un nuevo componente que no está listado aquí, documenta primero su estructura de tokens antes de codificarlo.
* **Regla 5 (Light-first):** La primera visita siempre usa el tema claro. El tema oscuro es opt-in mediante el control de tema y la elección explícita se persiste. No se sigue `prefers-color-scheme` automáticamente.
* **Regla 6 (Tokens, no hex):** Los únicos hexadecimales viven en la capa de tokens (`BrandColors` y `PortfolioTokens`). Los widgets consumen roles semánticos.
* **Regla 7 (Imagen del hero):** El wallpaper del hero es un recurso visual de fondo. La interfaz no muestra atribuciones ni información sobre la propiedad de la imagen.

### 2.6 Movimiento
* `--motion-reveal-duration`: 500ms; `--motion-slide-duration`: 220ms.
* `--motion-curve`: `easeOutCubic`; `--motion-distance`: 12px upward.
* Stagger entre elementos revelados: 60ms. Todo movimiento se omite si `MediaQuery.disableAnimations` está activo.

---

## 5. Elevación

* **Sombra:** Ninguna. La jerarquía se expresa con superficies, bordes de 1px y cambios de color; no se usan `boxShadow`, `elevation` ni `Material` elevado.
