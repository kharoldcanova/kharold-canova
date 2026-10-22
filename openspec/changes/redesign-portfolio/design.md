# Design

## Context

See `proposal.md` for motivation. The relevant current state:

- Flutter Web, single scrolling page. `Scaffold` uses `extendBodyBehindAppBar` with a transparent `AppBar`; `PortfolioPage` owns a `ScrollController` and a map of `GlobalKey`s used for anchor scrolling and active-section detection.
- `BrandTheme.light` is not light: it sets `scaffoldBackgroundColor` to `#000000` and `onSurface` to `#F0F0F0`. Colors live in `BrandColors`, while the dark theme duplicates literal values inside `current_theme.dart`.
- `ThemeBloc` exists and `MaterialApp` wires `theme`, `darkTheme`, and `themeMode`, but the state is a `bool isDark` and no control toggles it.
- `DESIGN.md` defines light and dark palettes, a 4/8px spacing grid, radii 10/16, and "no shadows", but has no tokens for text over imagery, hero scrim, navigation overlay, or on-primary. Its own rule 4 requires documenting new component tokens before coding.
- Fonts are fetched at runtime through `google_fonts`; `JetBrains Mono` is named in `DESIGN.md` but unused.
- `pubspec.yaml` bundles the whole `assets/` directory. Only `assets/photo.jpg` is referenced; `banner_background.png` and three `font-banner*.jpg` files account for roughly 3.4 MB and are unused.
- There is no `test/` directory.

## Goals / Non-Goals

**Goals:**

- Apply `DESIGN.md` literally to both themes and make every color read from a semantic token.
- Replace the hero portrait with the owner-supplied illustration and keep the identity block readable over it.
- Give the header two visual states (over-hero and scrolled) and five anchors with drawer parity.
- Introduce a light-first theme with an opt-in, persisted dark theme.
- Reduce the page to a coherent six-block sequence and quiet the loud elements (radar, services, certifications, footer).
- Replace the CV, add two wallpaper crops, and stop bundling unused assets.

**Non-Goals:**

- No backend, API, or data-source changes.
- No contact form; contact remains mail/phone/social links.
- No new pages or routes; the site remains a single scrolling page.
- No changes to portfolio copy beyond section labels and localization keys.
- No visual regression (golden) test suite; verification is analyzer plus widget smoke tests.
- No portrait photo in the shipped bundle.

## Decisions

### 1. Semantic tokens through a `ThemeExtension`

Extend `ColorScheme` usage for standard roles and add a `PortfolioTokens extends ThemeExtension<PortfolioTokens>` for roles Flutter does not model: `onImage`, `onImageMuted`, `onImageBorder`, `heroScrim`, `navSurface`, `focusRing`, `borderSubtle`, and `contentMaxWidth`. `AppTheme` builds both variants; widgets read `Theme.of(context).extension<PortfolioTokens>()!`.

*Why not constants:* constants cannot vary by mode, and the change exists to make light and dark real. *Why not a second parallel color class:* a `ThemeExtension` participates in theme animation and is testable via `ThemeData`.

`ColorScheme` gains `onPrimary: #FFFFFF` (light) and `onPrimary: #09090B` (dark), fixing today's white-on-light-blue button. `accent` is only used as a filled surface with a light label in dark mode.

### 2. `ThemeMode` state, light default, persisted choice

Replace `ThemeState.isDark` with `ThemeMode mode` (`light` initially). The toggle switches between `light` and `dark` only. An explicit choice is stored with `shared_preferences` and read before `runApp` so the first frame already uses the stored mode; no system-preference following.

*Alternatives:* `dart:html` localStorage (web-only, bypasses Flutter's plugin abstraction); following `platformBrightness` (rejected by the owner: first visit must be light).

*Consequence:* `main()` becomes async (`WidgetsFlutterBinding.ensureInitialized()`), and `ThemeBloc` gains a `setMode`/`toggle` event instead of a boolean flip.

### 3. Custom header instead of `AppBar`

Replace the `AppBar` with a `PreferredSize` header that renders a `Stack`: an `AnimatedContainer` background plus the nav row. `PortfolioPage` passes `isOverHero`, computed from the scroll offset against the hero height.

*Why:* `AppBar` cannot smoothly animate between a transparent background and a surface plus bottom border, and it forces Material title paddings that fight the five-anchor layout. *Alternative:* keep `AppBar` and change `backgroundColor` on scroll; simpler but produces a hard visual jump and cannot express the 1px border cleanly.

The drawer continues to use `Scaffold.drawer`; the custom header opens it through a `GlobalKey<ScaffoldState>` or a `Builder`, so `Scaffold.of(context).openDrawer()` remains valid.

### 4. Active-section detection stays position-based

Keep the existing nearest-to-top calculation but include a `certifications` key. Map the `knowledge` block to the `about` destination so the anchor stays active across both sub-blocks. Use a 2px underline (animated width) instead of the filled pill.

### 5. Hero as a two-layer stack with fixed crop assets

The hero is a `Stack`: `Image.asset` (`BoxFit.cover`, breakpoint-specific `alignment`), a two-stop gradient scrim (top for the header, bottom for the identity block), then the content column. Two exported WebP assets are used: a landscape crop for widths ≥1200px and a portrait crop below. The image fades in with a `frameBuilder` and has no parallax, keeping decode cost and motion low.

The identity block is bottom-left aligned on desktop and centered-left on mobile, over the calmest area of the chosen illustration. Type sizes remain 80/36 for the name and 38/20 for the role, documented in `DESIGN.md` as the display exception. The hero height is intentionally bounded below the viewport (68% clamped 500–600px on mobile, 72% clamped 540–700px on desktop) and is computed once for both the rendered hero and the page's scroll/header detection.

*Alternatives:* one asset with `Alignment` per breakpoint (risks bad crops), CSS-like background attachment (not available in Flutter), parallax (rejected for performance and reduced-motion).

### 6. Fonts bundled, `google_fonts` removed

Declare `Poppins` (400/500/600/700) and `JetBrains Mono` (400/500) in `pubspec.yaml` and reference them by family name. Remove the `google_fonts` dependency.

*Why:* runtime fetching causes a flash of unstyled text and a network dependency on every load; mono is now part of the visual system (eyebrows, stats, tags, install command). Both families are OFL-licensed.

### 7. Section re-organization

- `AboutSkillsWidget` adds an experience timeline from `PortfolioRepository.getExperiences()` (period, role, company, location, impact bullets) and replaces `RadarSkillsChart` with a grouped `SkillGroupsGrid` (AI & MCP, DevOps & Cloud, Frontend & Mobile, Backend & Data) rendered as technology chips. No numeric levels or radar remain.
- `services_widget.dart` becomes `knowledge_widget.dart` (`KnowledgeWidget`) with a `Conocimientos` heading, six cards, surface background, 1px border, and icon in `primary`.
- `PortfolioPage` wraps About plus Knowledge under one `about` key so the nav destination covers both.
- `CertificationsSection` receives its own key and nav entry.
- `FooterWidget` loses its solid `primary` fill. `ContactWidget` uses `--primary` as its dominant background with `--on-primary` text and transparent bordered cards, inverting that section's palette; the footer keeps `--bg-surface` and its top border.

### 8. Content data additions

`PortfolioRepository` gains `String? getMedium()` and a `PublishedSkill? getPublishedSkill()` entry (name, description, URL, optional install command). The Medium control and featured card render only when those values are non-null. `CertificationItem.color` is removed in favor of theme tokens.

### 9. Project cards lose hover-only content

Description and tech tags render permanently. Hover/focus only changes the 1px border to `primary`; no shadow, no translate, no `AnimatedCrossFade`. This removes the accessibility problem of content that only exists on pointer hover.

### 10. Verification

`flutter analyze` plus widget smoke tests: anchors render in order, theme toggle switches `ThemeMode` and persists, language toggle switches localized labels, drawer exposes all destinations, and the hero contains no image avatar. No golden tests; the visual review stays manual against `DESIGN.md`.

## Risks / Trade-offs

- **Illustration licensing and credit** → the owner supplies the asset and decides the credit line; the implementation records the source in `DESIGN.md` or the footer.
- **Text over a busy or bright area** → enforce the scrim and verify contrast against sampled pixels of the final asset; if it fails, adjust the crop or strengthen the local scrim rather than shrinking the type.
- **`DESIGN.md` gaps** → document the new tokens and the hero display exception in `DESIGN.md` before touching widgets, per its rule 4.
- **Custom header breaks drawer opening** → keep `Scaffold.drawer` and open it through the scaffold's own context; cover it with a widget test.
- **Persisted theme flash** → read preferences before `runApp`; assert in a test that a stored dark mode produces a dark first frame.
- **Bundled fonts increase repository size** → subset to Latin and only the weights actually used.
- **Large wallpaper on mobile** → separate portrait crop, WebP, and a fade-in; avoid decoding the landscape asset on small screens.
- **Removing the photo asset** → switch `pubspec.yaml` from the `assets/` directory to an explicit file list so unused files stay in git but are not shipped.

## Migration Plan

Static site; no data migration. Implement in this order: `DESIGN.md` tokens → theme state and tokens → header → hero → sections → assets/CV/metadata → tests. Deploy remains the existing GitHub Pages workflow. Rollback is a branch revert; no persisted user data beyond a theme preference key.

## Open Questions

- Final wallpaper file, its two crops, and the credit line (owner-supplied).
- Medium profile URL and the published skill's name, link, and install command; the UI degrades gracefully until they exist.
- Whether the owner wants the portrait photo used anywhere else later; it is excluded from the bundle for now.

## Owner additions (2026-10-22)

### 11. Presentation mode reuses the page sections instead of duplicating them

*Why:* a slide deck that copies the content would drift from the page and double the maintenance surface. *How:* the page and the presentation both build their sections from one shared builder, and the presentation is a full-screen route with a `PageView`, on-screen controls, a position indicator, and an `Escape`/`Arrow`/`Space` shortcut layer. The route restores the previous scroll offset when it closes.

### 12. The dark palette becomes near-black

*Why:* `#242424` reads as gray, not black. *How:* `--bg-base` moves to `#0A0A0A`, `--bg-surface` to `#121212`, `--bg-elevated` to `#1C1C1C`, `--border` to `#2A2A2A`, and `--nav-surface` to the new base at the same alpha; text and accent tokens are unchanged, and the secondary text token is re-checked for AA contrast against the new surfaces. The values live only in `DESIGN.md` and the theme token file.

### 13. The owner wallpaper is exported as two WebP crops and credited in the hero

*Why:* the hero still shows placeholder crops, and the owner's wallpaper (`karem-adem-VYhlOMPORj8-unsplash.png`, 4000×2182, Karem Adem on Unsplash) is now available. *How:* the landscape source is cropped to 1920×1047 and the portrait crop to 1080×1440, both WebP under 250 KB, replacing the placeholders in place; the credit line is localized, links to the Unsplash photo in a new tab, and the source plus credit are recorded in `DESIGN.md` per its rule 7. The unreferenced bundled images (`banner_background.png`, `font-banner*.jpg`, `photo.jpg`) are dropped from the bundle because the wallpaper replaces them.

### 14. Motion is token-driven and reduced-motion aware

*Why:* the redesign removed the scroll-triggered reveal and the page lost its sense of progression. *How:* the deleted `AnimateOnVisible` widget is restored and applied to section content as a fade plus a short rise, motion tokens (duration, curve, distance) are documented in `DESIGN.md`, and every animation checks `MediaQuery.disableAnimations` so reduced-motion platforms render the final state immediately. Animations only touch opacity, transform, and border color: no shadows, no new literal colors.

### Risks / Trade-offs (owner additions)

- **Slide content drift** → one shared section builder serves both the page and the presentation.
- **Keyboard focus traps in a full-screen route** → the route owns focus, and Escape always closes.
- **Bright wallpaper behind white text** → sample the pixels behind the identity block and the header, and strengthen the scrim tokens if the 3:1 / 4.5:1 ratios are not met.
- **Near-black surfaces hiding borders** → the border token is re-tuned against the new base so card edges stay visible in dark mode.
