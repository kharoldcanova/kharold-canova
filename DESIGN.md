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

**Un solo acento por modo:** `--primary` es el único color de acento (azul `#0033CC` en claro, azul apagado `#8AA8FF` en oscuro). No se usan segundos acentos, rojos decorativos ni neón; bordes y superficies son neutros. `--success`, `--warning` y `--error` quedan reservados para estados, nunca para decorar.

| Token Semántico | Valor Hex / Light | Valor Hex / Dark | Uso Principal |
| :--- | :--- | :--- | :--- |
| `--bg-base` | `#FFFFFF` | `#000000` | Fondo principal de la aplicación |
| `--bg-surface` | `#FFFFFF` | `#121212` | Tarjetas, contenedores, paneles |
| `--bg-elevated` | `#ededed` | `#1C1C1C` | Modales, dropdowns, elementos flotantes |
| `--text-primary` | `#000000` | `#f2f4f7` | Títulos y texto principal |
| `--text-secondary` | `#3F3F46` | `#aaabad` | Subtítulos, metadatos, iconos inactivos |
| `--primary` | `#0033CC` | `#8AA8FF` | Único acento: botones principales, enlaces, estados activos |
| `--success` | `#166534` | `#4ADE80` | Mensajes de éxito, estados online, confirmaciones |
| `--warning` | `#92400E` | `#FACC15` | Alertas, advertencias |
| `--error` | `#B91C1C` | `#F87171` | Errores, acciones destructivas |
| `--on-primary` | `#FFFFFF` | `#0A1433` | Texto e iconos sobre `--primary` |
| `--border` | `#111111` | `#3F3F46` | Bordes, separadores, líneas divisorias |
| `--border-subtle` | `#111111` @ 12% | `#F2F4F7` @ 12% | Bordes de tarjetas, divisores de sección, aristas de las redes |
| `--nav-surface` | `#FFFFFF` @ 92% | `#000000` @ 92% | Fondo del header tras hacer scroll |
| `--focus-ring` | `#0033CC` | `#8AA8FF` | Anillo de foco de accesibilidad (= `--primary`) |
| `--content-max` | `1200px` | `1200px` | Ancho máximo del grid de contenido |

### 2.2. Tipografía
* **Modos claro y oscuro:** la misma familia sans: `Poppins`, `Geist`, `Roboto`, system-ui, sans-serif. El modo oscuro solo cambia la paleta, nunca la tipografía.
* **Monospace:** `JetBrains Mono` solo dentro de la terminal opcional (3.6). Fechas, métricas, etiquetas y chips usan la sans; las cifras alineadas usan `tabularFigures`.

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

### 2.5. Layout y Navegación
* **Grid de contenido:** ancho máximo `--content-max` (1200px), centrado, con gutters de 80px desde 900px y 24px por debajo. Header, hero y secciones comparten ese mismo borde izquierdo.
* **Breakpoints:** 900px separa header con enlaces / drawer; 920px separa hero a dos columnas / apilado; 760px separa grillas de 2 columnas / 1 columna. Todo se prueba a 320, 360, 390, 768, 900, 1200, 1440 y 1920px.
* **Hero:** su altura la marca el contenido (no el viewport). Izquierda: identidad; derecha: las redes neuronales (3.2). Bajo 920px las redes van debajo.
* **Header:** transparente sobre el hero; tras hacer scroll usa `--nav-surface` y un borde inferior de 1px en `--border-subtle`.
* **Indicador activo:** subrayado de 2px en `--primary`, sin pills ni fondos rellenos.
* **Foco:** anillo visible con `--focus-ring`.
* **Separación entre secciones:** borde superior de 1px en `--border-subtle`; sin eyebrows numerados (`01 — TÍTULO`), el título basta.

### 2.6. Voz del contenido
* Primera persona y frases que diría una persona: "Hola, soy", "Hablemos", "Con qué trabajo". Nada de fórmulas de CV en el cuerpo de la página ("tiempo completo", "único responsable", listas de palabras clave como eyebrow).
* La única fórmula permitida es la etiqueta de estado `Disponibilidad inmediata` / `Available now` (hero y contacto).
* Ubicación, modalidad e idiomas van en una línea discreta bajo los canales de contacto, no en "Sobre mí".
* Los datos (cifras, fechas, stack) salen del CV principal y no se inventan.

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

### 3.2. Hero
* Jerarquía: `HOLA, SOY` + etiqueta `Disponibilidad inmediata` (punto en `--success`: es un estado), nombre (68px / 42px en móvil, w600), rol "Desarrollador full stack, entre **Flutter** y la **IA**." con las dos palabras en `--primary`, y una frase de valor en `--text-secondary`.
* Acciones: `Ver proyectos` (primaria) y `Descargar CV ↗` (enlace de texto). Debajo, `GitHub ↗ · LinkedIn ↗ · Medium ↗` como enlaces de texto. Sin riel social flotante, sin imagen de fondo ni retrato.
* **Redes neuronales (sello):** panel con borde `--border-subtle` y título "Las redes detrás de mis proyectos". Tres redes, una por familia de proyecto: `Visión` (LAIN · MiniCPM-V), `Voz` (LAIN · Kokoro) y `Texto → SQL` (ia-sql · Ollama).
  * En reposo: aristas en `--border-subtle`, nodos en `--text-secondary` tenue, sin animación.
  * Al pasar el cursor: la red se activa (aristas y nombre hacia `--primary`, pulsos que viajan capa a capa, nodos que se iluminan y se inclinan hacia el cursor) y se calma al salir.
  * Táctil: un toque lanza una ráfaga de pulsos en la red tocada.
  * Columnas lado a lado desde 420px de ancho del panel (300px de alto); por debajo, filas apiladas (480px).
  * El `Ticker` solo corre mientras algo se mueve (intro de 2,5s, hover, ráfaga); una página quieta no pide frames. Con `disableAnimations` se dibuja estática.
  * Implementación: `CustomPainter` en `neural_networks.dart`, sin imágenes ni dependencias.

### 3.3. Navegación
* Header: monograma `KC` + nombre (el nombre se oculta bajo 480px) · `Sobre mí`, `Experiencia`, `Proyectos`, `Contacto` · `ES/EN`, tema y botón outline `CV ↗`. GitHub, LinkedIn, Medium y la terminal no viven en el header.
* Bajo 900px los enlaces pasan al drawer (botón de menú a la derecha).
* El drawer lista `Inicio`, `Sobre mí`, `Experiencia`, `Proyectos`, `Formación` y `Contacto`; cierra al seleccionar y con `Escape`, devolviendo el foco al menú.
* No hay modo presentación.
* Orden de la página: Hero · Sobre mí · Experiencia · Proyectos · Con qué trabajo · Formación y certificaciones · Contacto · Footer.

### 3.4. Formularios e Inputs
* Altura estándar: `40px` (Desktop) / `44px` (Mobile touch target).
* Fondo: `--bg-surface`.
* Borde: `--border`. En foco cambia a `--primary`.
* Mensaje de error: Texto en `--error` situado exactamente debajo del input con margen `xs`.

### 3.5. Secciones de contenido
* **Sobre mí:** foto circular pequeña (`assets/profile.jpg`, 320px; 132px en desktop, 96px en móvil), dos párrafos en primera persona y una franja de 4 métricas del CV (4 · ~115 · 2 · 3) en una caja con borde: 4 columnas, 2 bajo 760px. Las cifras usan `--primary`.
* **Experiencia:** línea de tiempo; periodo como `sep 2023 – sep 2026` / `Sep 2023 – Sep 2026` en `--text-secondary`, rol, empresa en `--primary` y viñetas en primera persona.
* **Proyectos:** tarjetas enteras clicables con borde `--border-subtle` que pasa a `--primary` (y sube 2px) en hover/foco; categoría, título, descripción completa, chips de stack sobre `--bg-elevated` y `GitHub ↗` / `Ver sitio ↗`. Cada fila toma la altura de su tarjeta más alta (3 / 2 / 1 columnas).
* **Con qué trabajo:** los 5 grupos del CV como lista de dos columnas (una bajo 760px): título y tecnologías separadas por comas.
* **Contacto:** en claro, fondo `--primary` con `--on-primary`; en oscuro, `--bg-elevated` con `--text-primary`. Izquierda: etiqueta de disponibilidad, "Hablemos" y un párrafo; derecha: email (seleccionable, botón `Copiar`), LinkedIn y GitHub, y la línea discreta de ubicación/idiomas. Apilado bajo 860px.
* El footer conserva `--bg-surface` con su borde superior y el botón `>_` de la terminal.

### 3.6. Terminal (easter egg)
* El modo oscuro **no** es la terminal: es el mismo sitio con paleta oscura. La terminal es un extra opcional.
* Se abre desde el botón `>_` del footer (tooltip `Abrir terminal` / `Open terminal`) o con la tecla `` ` ``, como ruta a pantalla completa con fundido.
* Se cierra con el botón ✕ de la barra, el punto rojo de la ventana o `Escape`, y vuelve al portafolio.
* Siempre se dibuja con su propio tema (`AppTheme.getTerminalTheme()`), sea cual sea el modo activo: ventana `kharold@portfolio:~`, prompt `whoami`, pestañas navegables, tipografía `JetBrains Mono` y scanlines muy tenues. El cursor respeta `disableAnimations`.
* Su paleta vive aislada en `TerminalColors` y no se usa fuera de la terminal:

| Token terminal | Valor | Uso |
| :--- | :--- | :--- |
| `green` | `#4ADE80` | Prompt, pestaña activa, acción principal |
| `cyan` | `#56D4DD` | Información y enlaces secundarios |
| `yellow` | `#E3C667` | Comandos y metadatos destacados |
| `magenta` | `#D2A8FF` | Etiquetas y acentos secundarios |
| `border` | `#264A33` | Bordes de la ventana y la navegación |

---

## 4. Guías de Implementación para la IA

* **Regla 1 (Cero Hardcoding):** Nunca utilices colores en hexadecimal directos (ej. `#3B82F6`) en los componentes de UI. Utiliza siempre las variables semánticas o tokens definidos en la sección 2.
* **Regla 2 (Consistencia Responsive):** Prioriza un enfoque *mobile-first*. Los contenedores principales deben adaptarse fluidamente usando Flexbox o Grid.
* **Regla 3 (Naming Conventions):** Mantén coherencia en los nombres de clases o widgets según el framework del proyecto (ej. camelCase para Flutter, kebab-case para CSS/Tailwind).
* **Regla 4 (Feedback de Cambios):** Si se añade un nuevo componente que no está listado aquí, documenta primero su estructura de tokens antes de codificarlo.
* **Regla 5 (Light-first):** La primera visita siempre usa el tema claro. El tema oscuro es opt-in mediante el control de tema y la elección explícita se persiste. No se sigue `prefers-color-scheme` automáticamente.
* **Regla 6 (Tokens, no hex):** Los únicos hexadecimales viven en la capa de tokens (`BrandColors`, `TerminalColors` y `PortfolioTokens`). Los widgets consumen roles semánticos.
* **Regla 7 (Hero sin imagen):** El hero no carga imágenes de fondo. Cualquier recurso visual futuro es secundario al nombre y no muestra atribuciones.

### 2.7 Movimiento
* `--motion-reveal-duration`: 500ms; `--motion-slide-duration`: 220ms.
* `--motion-curve`: `easeOutCubic`; `--motion-distance`: 12px upward.
* Stagger entre elementos revelados: 60ms. Todo movimiento se omite si `MediaQuery.disableAnimations` está activo.

---

## 5. Elevación

* **Sombra:** Ninguna. La jerarquía se expresa con superficies, bordes de 1px y cambios de color; no se usan `boxShadow`, `elevation` ni `Material` elevado.
