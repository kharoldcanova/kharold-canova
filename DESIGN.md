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
| `--border-subtle` | `#111111` @ 40% | `#3F3F46` @ 40% | Divisores internos y metadatos |
| `--nav-surface` | `#FFFFFF` @ 92% | `#000000` @ 92% | Fondo del header tras hacer scroll |
| `--focus-ring` | `#0033CC` | `#8AA8FF` | Anillo de foco de accesibilidad (= `--primary`) |
| `--content-max` | `1200px` | `1200px` | Ancho máximo del grid de contenido |

### 2.2. Tipografía
* **Modos claro y oscuro:** la misma familia sans: `Poppins`, `Geist`, `Roboto`, system-ui, sans-serif. El modo oscuro solo cambia la paleta, nunca la tipografía.
* **Terminal (easter egg):** `JetBrains Mono`, `Fira Code`, monospace, solo dentro de la terminal opcional (3.8).

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
* **Grid de contenido:** ancho máximo `--content-max` (1200px), centrado, con gutters de 80px en desktop y 24px en mobile.
* **Hero:** altura acotada al 68% del viewport en mobile (mín. 500px, máx. 600px) y al 72% en desktop (mín. 540px, máx. 700px). La identidad va centrada-izquierda en todos los anchos. El nombre usa `Hero Display` y el rol `Hero Role`; esta es la única excepción a la escala tipográfica estándar.
* **Hero · jerarquía:** nombre (`Hero Display`), rol (`Hero Role`), eyebrow mono en mayúsculas (`--text-secondary`) y una fila de acciones. El rol debe leerse antes que cualquier otro metadato.
* **Hero · acciones:** `Descargar CV` (primaria), `Explorar sistemas de IA` (outline) y `Contáctame` (outline) en desktop; en mobile se mantienen CV, `Explorar sistemas de IA` y los accesos directos a GitHub/LinkedIn.
* **Hero · enlaces sociales:** en desktop, riel vertical abajo-derecha con GitHub, LinkedIn y email; botones de 44px con borde `--border`.
* **Hero · color:** fondo liso `--bg-base`; texto y controles usan los roles de tinta (`--text-primary`, `--text-secondary`, `--border`) en todos los anchos y en ambos modos. Bajo 700px se omite `Contáctame` para que la fila de acciones no se apile. Sin imagen, scrim, parallax ni sombras.
* **Header:** transparente sobre el hero; tras hacer scroll usa `--nav-surface` y un borde inferior de 1px.
* **Indicador activo:** subrayado de 2px en `--primary`, sin pills ni fondos rellenos.
* **Foco:** anillo visible con `--focus-ring`.
* **Contacto:** en claro, fondo dominante `--primary` con texto e iconos `--on-primary`; en oscuro, `--bg-elevated` con `--text-primary`. El footer conserva `--bg-surface` y su borde superior.

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
* Fondo liso `--bg-base` en ambos modos: sin ilustración, wallpaper, retrato ni avatar. El nombre, el rol y las acciones mandan.
* Si en el futuro se añade una ilustración, va como elemento lateral que no compita con el nombre, nunca como fondo a sangre.
* El modo oscuro muestra el mismo hero, header y secciones que el claro; solo cambia la paleta.
* Experiencia, proyectos y certificaciones se localizan según el idioma activo; los enlaces sociales usan tarjetas terminales uniformes en columnas responsivas.
* El resumen de foco profesional aparece como `Desarrollo Full Stack · IA Aplicada` / `Full Stack Development · Applied AI`.
* La acción principal usa `--primary` con `--on-primary`; la secundaria es outline con `--border` y `--text-primary`.
* El CV se abre en una pestaña nueva.

### 3.3. Navegación
* Seis destinos: `Inicio`, `IA`, `Sobre mí`, `Proyectos`, `Certificaciones`, `Contacto`.
* En desktop, GitHub, LinkedIn y CV viven en el header como iconos persistentes; Medium y la presentación se muestran solo cuando el ancho lo permite (1360px y 1280px respectivamente).
* El header es transparente sobre el hero y pasa a `--nav-surface` con borde inferior al hacer scroll.
* El estado activo se indica con un subrayado de 2px, nunca con una pill rellena.
* El drawer replica todos los destinos y acciones; cierra al seleccionar y con `Escape`, devolviendo el foco al control de menú.
* El drawer y el footer exponen GitHub, LinkedIn, email y CV sin depender del hero.

### 3.4. Formularios e Inputs
* Altura estándar: `40px` (Desktop) / `44px` (Mobile touch target).
* Fondo: `--bg-surface`.
* Borde: `--border`. En foco cambia a `--primary`.
* Mensaje de error: Texto en `--error` situado exactamente debajo del input con margen `xs`.

### 3.5. Sección de Contacto
* En modo claro: fondo dominante `--primary` y texto `--on-primary`.
* En modo oscuro: fondo neutro `--bg-elevated` y texto `--text-primary`, para que el azul apagado siga siendo el único acento.
* Cuatro canales en cuadrícula 2×2 (desktop) o 1 columna (mobile): email, teléfono, GitHub y LinkedIn.
* Tarjetas de contacto transparentes con borde de 1px; el hover y el foco solo cambian el borde, nunca oscurecen imágenes.
* El footer no se invierte: conserva `--bg-surface` con su borde superior de 1px.

### 3.6. Experiencia y Stack Técnico
* La experiencia profesional vive dentro de `Sobre mí` como una línea de tiempo: periodo en mono, rol como título, empresa y ubicación, y viñetas de impacto.
* El stack técnico reemplaza el radar por tarjetas agrupadas por área (`IA & MCP`, `DevOps & Cloud`, `Frontend & Móvil`, `Backend & Datos`).
* Cada grupo muestra tecnologías como chips; no se usan niveles numéricos, porcentajes ni gráficos de radar.
* En desktop los grupos van en dos columnas; en mobile, en una sola columna.

### 3.7. Sistemas de Inteligencia Artificial y Agentes
* Es el primer bloque de contenido después del hero y tiene destino propio en la navegación (`IA`).
* Orden curado y fijo: `ia-sql`, `Alma`, `LAIN`. La sección no depende del orden del listado general de proyectos.
* Encabezado `01 — SISTEMAS DE INTELIGENCIA ARTIFICIAL Y AGENTES`, descripción de posicionamiento y etiqueta `Proyectos destacados`.
* Tarjetas de altura uniforme: icono, índice, título, línea de impacto en mono con `--primary`, descripción, hasta 3 tecnologías y contador `+N`, y acción `Ver en GitHub`.
* La cuadrícula usa 3 columnas en desktop, 2 en tablet y 1 en mobile. El hover y el foco solo cambian el borde a `--primary`.
* Al final, un enlace outline a todos los repositorios del perfil.
* La terminal opcional (3.8) la reutiliza como pestaña `ai`, sin duplicar contenido.

### 3.8. Terminal (easter egg)
* El modo oscuro **no** es la terminal: es el mismo sitio con paleta oscura. La terminal es un extra opcional.
* Se abre desde el botón `>_` del footer (tooltip `Abrir terminal` / `Open terminal`) como ruta a pantalla completa con fundido, igual que el modo presentación.
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

### 2.6 Movimiento
* `--motion-reveal-duration`: 500ms; `--motion-slide-duration`: 220ms.
* `--motion-curve`: `easeOutCubic`; `--motion-distance`: 12px upward.
* Stagger entre elementos revelados: 60ms. Todo movimiento se omite si `MediaQuery.disableAnimations` está activo.

---

## 5. Elevación

* **Sombra:** Ninguna. La jerarquía se expresa con superficies, bordes de 1px y cambios de color; no se usan `boxShadow`, `elevation` ni `Material` elevado.
