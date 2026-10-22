# Proposal

## Why

The portfolio's implementation has drifted from `DESIGN.md`: the "light" theme is actually black with purple accents, cards use shadows the design system forbids, section styling is inconsistent, and several assets and controls are unfinished. The owner wants a minimalist, illustration-led redesign that follows `DESIGN.md` literally, opens in a real light theme, offers an opt-in dark mode, and presents current content (AI & DevOps CV, published skill, certifications) through a clearer five-anchor structure.

## What Changes

- Replace the hero portrait with a full-bleed illustration supplied by the owner, keeping the name at its current display size and the role at its current size. Add a primary "Descargar CV" action and a secondary contact action.
- Rebuild the header as a five-anchor navigation (`Inicio`, `Sobre mí`, `Proyectos`, `Certificaciones`, `Contacto`) that is transparent over the hero and gains a surface background and border after scrolling. Add a Medium link, a theme toggle, and the existing language toggle. Provide the same destinations and actions in the mobile drawer.
- Introduce a real light theme as the first-visit default and an opt-in dark theme, using the `DESIGN.md` palettes and contrast-safe `on-primary` values. Explicit user choice is remembered across reloads.
- Reorganize the page: `Sobre mí` groups the bio, experience stats, a professional experience timeline, a grouped technical stack, and a `Conocimientos` sub-block (the current services cards). `Proyectos` gains a featured published-skill card above the project grid. `Certificaciones` becomes its own navigation anchor. The standalone `Servicios` section is removed. Footer, certifications, and services cards are restyled to the design system's restrained palette; the confusing radar is replaced by grouped technology chips.
- Document the new image-hero, navigation-overlay, focus, and layout tokens in `DESIGN.md`, and record the hero type scale as a documented exception.
- Replace the published CV with `CV Kharold Canova - AI & DevOps Engineer.pdf`, add the wallpaper in desktop and mobile crops, remove unused bundled assets, and update web metadata.
- Add widget smoke tests for navigation, theme switching, and language switching; the project currently has no test directory.
- **BREAKING**: the visual identity changes from the current purple-on-black to the `DESIGN.md` white/blue light palette and dark neutral palette. No public API or data contract changes.

## Capabilities

### New Capabilities

- `portfolio-hero`: full-viewport illustrated hero with the owner's name and role, CV download, contact action, and legibility guarantees over imagery.
- `portfolio-navigation`: five-anchor header, transparent-to-surface scroll behavior, active-section indication, Medium/theme/language actions, and responsive drawer parity.
- `portfolio-theme`: light-first theme selection, opt-in dark mode, persistence of explicit choice, and contrast-safe token mapping.
- `portfolio-sections`: composition and styling requirements for about/knowledge, projects with a featured published skill, certifications, contact, stats, and footer.

### Modified Capabilities

None. No existing specs exist in this repository.

## Impact

- **Widgets**: `lib/screens/widgets/hero_widget.dart`, `header_widget.dart`, `portfolio_drawer.dart`, `portfolio_page.dart`, `about_skills_widget.dart`, `experience_timeline.dart`, `skill_groups_grid.dart`, `knowledge_widget.dart`, `portfolio_widget.dart`, `certifications_section.dart`, `contact_widget.dart`, `footer_widget.dart`, `section_shell.dart`.
- **Theme and state**: `lib/config/theme/brand_theme.dart`, `current_theme.dart`, `lib/bloc/theme/*`, `lib/main.dart`.
- **Localization**: `lib/l10n/app_en.arb`, `lib/l10n/app_es.arb` for `Sobre mí`, `Conocimientos`, `Certificaciones`, theme tooltips, and Medium.
- **Assets and web**: `assets/` (new wallpaper crops, remove unused images), `web/cv-flutter.pdf` replacement, `web/index.html`, `web/manifest.json`, `pubspec.yaml`.
- **Design system**: `DESIGN.md` gains image/nav/focus/layout tokens and the hero type-scale exception.
- **Dependencies**: likely `shared_preferences` for persisting the explicit theme choice, and bundled Poppins/JetBrains Mono assets to remove runtime font fetching. Final selection is recorded in `design.md`.
- **Tests**: new `test/` directory with widget smoke tests.

## Owner additions (2026-10-22)

The owner extended the same redesign with four requests: a presentation mode, a deeper dark palette, the owner-supplied wallpaper, and restored motion.

### What Changes

- Add a presentation mode: a play control in the header and the mobile drawer opens a full-screen slide deck that renders the same sections as the scrolling page, navigable by keyboard, on-screen controls, and Escape.
- Move the dark palette from mid-gray (`#242424` base) to near-black (`#0A0A0A` base family) through the existing semantic tokens, keeping WCAG AA contrast and the no-literal-colors rule.
- Replace the placeholder hero crops with the owner's wallpaper, exported as a desktop landscape WebP and a mobile portrait WebP inside the weight budget, with a localized credit line and the provenance recorded in `DESIGN.md`.
- Restore the scroll-triggered reveal animation removed by the redesign, document motion tokens, and add restrained secondary motion (staggered items inside a revealed section, a short slide transition) that honors reduced-motion preferences.

### New Capabilities

- `portfolio-presentation`: presentation entry point, slide composition, navigation, and responsiveness.
- `portfolio-motion`: scroll-triggered reveal, reduced-motion behavior, token-driven motion, and presentation/theme transitions.

### Modified Capabilities

- `portfolio-theme`: the dark palette becomes near-black instead of mid-gray.
- `portfolio-hero`: the hero renders the owner-supplied wallpaper with a credit line.

### Impact

- **Widgets**: `lib/screens/widgets/header_widget.dart`, `portfolio_drawer.dart`, `portfolio_page.dart`, `hero_widget.dart`, new `presentation_*` widgets, restored `animate_on_visible.dart`.
- **Theme and tokens**: `lib/config/theme/brand_theme.dart`, `current_theme.dart`, `DESIGN.md` dark palette and new motion tokens.
- **Assets**: `assets/hero-desktop.webp`, `assets/hero-mobile.webp`, removal of the unreferenced bundled images, `pubspec.yaml` asset list.
- **Localization**: `lib/l10n/app_en.arb` and `app_es.arb` for the presentation control and the photo credit.
