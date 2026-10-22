# Tasks

## 1. Design system foundation

- [ ] 1.1 Extend `DESIGN.md` with the image-hero, navigation, focus, and layout tokens (`on-image`, `on-image-muted`, `on-image-border`, `hero-scrim`, `on-primary`, `nav-surface`, `focus-ring`, `border-subtle`, `content-max`) and document the 80/36 hero display exception plus the light-first rule; verify every token used by the specs appears in the document and no new literal hex is introduced elsewhere.
- [ ] 1.2 Implement `PortfolioTokens` as a `ThemeExtension` and set `ColorScheme.onPrimary` to `#FFFFFF` (light) and `#09090B` (dark); rebuild `AppTheme` light and dark from the `DESIGN.md` values, including radii 10/16 and zero shadows; verify a widget test asserting the key light/dark colors passes and `flutter analyze` is clean.
- [ ] 1.3 Bundle Poppins (400/500/600/700) and JetBrains Mono (400/500), remove the `google_fonts` dependency, and build the text theme from those families; verify `flutter pub get` succeeds and a widget test renders text without any runtime font request.

## 2. Theme behavior

- [ ] 2.1 Replace `ThemeState.isDark` with `ThemeMode mode`, defaulting to light, and expose a toggle event that switches only between light and dark; verify a unit test covers the initial state and both transitions.
- [ ] 2.2 Persist an explicit choice with `shared_preferences`, read it before `runApp`, and pass the stored mode to `ThemeBloc`; verify a test restores dark from storage and that clearing storage restores light.
- [ ] 2.3 Wire the theme control into the header and drawer with a destination icon and localized tooltip; verify toggling updates `MaterialApp.themeMode` and the control's tooltip in both locales.

## 3. Header and navigation

- [ ] 3.1 Replace `AppBar` with a `PreferredSize` header that renders transparent over the hero and a 92% surface plus 1px bottom border after scrolling; verify a widget test exercises both states through the scroll offset.
- [ ] 3.2 Render the five anchors in the required order with a 2px active underline and remove the filled pill state; verify anchor order, active-section updates, and that no filled pill remains.
- [ ] 3.3 Add the language toggle as an `ES/EN` control, the theme toggle, and a Medium control that renders only when a URL is configured; verify all three with and without a Medium URL.
- [ ] 3.4 Rebuild the mobile drawer with the five anchors and every utility action, closing on selection and on Escape with focus returned to the menu control; verify at 390px that the drawer exposes every destination and closes correctly.
- [ ] 3.5 Add a `certifications` section key and map the knowledge sub-block to the `about` destination so the anchor stays active across both; verify scrolling through Sobre mí and Conocimientos keeps Sobre mí active, and that Certificaciones activates on arrival.
- [ ] 3.6 Add l10n keys for `Sobre mí`, `Conocimientos`, `Certificaciones`, theme tooltips, and Medium in both `app_es.arb` and `app_en.arb`; verify no hardcoded user-facing label remains in the header.

## 4. Hero

- [ ] 4.1 Receive the owner's wallpaper, export desktop and mobile WebP crops within the agreed weight budget, record the source and credit line, and verify both assets exist at the expected dimensions and sizes.
- [ ] 4.2 Rebuild the hero as a `Stack` with the illustration, a two-stop scrim, and the identity block; remove `assets/photo.jpg` from the rendered hero; verify no `CircleAvatar` or portrait asset is referenced and the layout holds at 360px and 1440px.
- [ ] 4.3 Keep the name at 80/36 and the role at 38/20, position the identity block bottom-left on desktop and centered-left on mobile, and verify no clipping or horizontal overflow from 360px to 1920px.
- [ ] 4.4 Replace the CV link with the new AI & DevOps PDF, open it in a new tab, and add the secondary contact action; verify the resolved URL, the new-tab behavior, and that the contact action scrolls and marks Contacto active.
- [ ] 4.5 Measure contrast over the final illustration for the name, role, header labels, and hero buttons, and adjust the scrim until large text reaches 3:1 and normal text 4.5:1; verify with sampled pixels behind each text zone.

## 5. Content sections

- [x] 5.1 Fold the stats section into Sobre mí, replace the purple 320x400 placeholder with a monospace stats panel, add the professional experience timeline from the repository, and replace the radar chart with a grouped technical stack grid; verify no hardcoded chart colors remain, the experience shows role/company/period/highlights, and the stack renders grouped technology chips without numeric levels.
- [ ] 5.2 Rename `services_widget.dart` to `knowledge_widget.dart`, render six capability cards on surface with a 1px border and `primary` icon, and remove the standalone Servicios section and heading; verify six localized cards render and no "Servicios" heading appears.
- [ ] 5.3 Add the featured published-skill card above the project grid, rendered only when a published-skill entry is configured, with name, description, link or install command; verify both configured and unconfigured states.
- [ ] 5.4 Rebuild project cards without shadows or hover-only content, showing description and tech tags permanently and changing only the border on hover or focus; verify description visibility, border behavior, and the absence of `boxShadow`.
- [ ] 5.5 Give Certificaciones its own section with heading, description, and a monochrome list of every certification showing brand, title, and date; verify all repository certifications render and no per-item color survives a theme switch.
- [x] 5.6 Restyle Contacto with a primary-blue inverted palette and on-primary text, keep the footer on surface with a top border, apply the 1200px content grid with 24/80px gutters, and add the 12px monospace eyebrow plus 32px heading pattern to each section; verify no horizontal overflow at 360px, the contact text/cards use the inverted on-primary palette in both themes, and the footer has a top border and no filled primary background.

## 6. Assets, CV, and web metadata

- [ ] 6.1 Replace `web/cv-flutter.pdf` with `web/cv-kharold-canova.pdf` and update the only reference; verify the file exists and the button opens it in a new tab.
- [ ] 6.2 Switch `pubspec.yaml` from the whole `assets/` directory to an explicit file list that excludes the unused banners and portrait; verify the built asset manifest omits them and the web build size drops.
- [ ] 6.3 Update `web/index.html` title, description, and social preview tags, and `web/manifest.json` name and colors; verify the built page shows the new title and description.
- [ ] 6.4 Add nullable `getMedium()` and `getPublishedSkill()` to `PortfolioRepository`; verify the header and featured card hide cleanly when both are null and render when fixtures are supplied.

## 7. Integration verification

- [ ] 7.1 Run `flutter analyze` and confirm zero issues.
- [ ] 7.2 Run `flutter test` and confirm all smoke and unit tests pass.
- [ ] 7.3 Manually check 360px, 768px, 1200px, 1440px, and 1920px widths in both themes, confirming no horizontal overflow, correct header states, and drawer parity.
- [ ] 7.4 Build the web release and verify the output size, the new CV, the wallpaper assets, and no runtime font fetch.
- [ ] 7.5 Re-read `DESIGN.md` against the implementation and reconcile any deviation before closing the change.

## Workflow follow-up

- Archive the change after the project's review requirements are satisfied.
- Deploy through the existing GitHub Pages workflow and verify the live site.
- Add the final Medium URL and published-skill details when the owner provides them; the UI already degrades gracefully without them.

## 8. Dark palette depth

- [ ] 8.1 Redefine the dark surface tokens as near-black (`--bg-base` `#0A0A0A`, `--bg-surface` `#121212`, `--bg-elevated` `#1C1C1C`, `--border` `#2A2A2A`, `--nav-surface` over the new base) in `DESIGN.md` and `lib/config/theme/brand_theme.dart`, removing `#242424`, `#2F2F2F`, `#3E3E3E`, and `#474747`; verify no literal color survives outside the token file.
- [ ] 8.2 Re-check body text, secondary text, borders, chips, cards, header, drawer, and footer against the new surfaces; verify a widget test asserts the new background value and that `flutter analyze` and `flutter test` are clean.

## 9. Presentation mode

- [ ] 9.1 Add a presentation entry control to the header utility row and the mobile drawer with a localized label; verify the control renders in both places and starts the presentation.
- [ ] 9.2 Extract the page sections into a shared builder so the scrolling page and the presentation render the same widgets; verify the presentation shows hero, about, knowledge, projects, certifications, and contact in that order with a "1 / 6" position indicator.
- [ ] 9.3 Implement slide navigation: on-screen previous and next controls, arrow keys, space, Escape to close, and the position indicator; verify keyboard navigation, the last-slide boundary, and that closing restores the previous scroll position.
- [ ] 9.4 Make the presentation responsive from 360px to 1920px, theme-aware, and reduced-motion safe; verify there is no horizontal overflow and that toggling the theme updates the open presentation.

## 10. Motion

- [ ] 10.1 Restore `AnimateOnVisible` and apply a fade-plus-rise reveal to each section's content; verify a section that scrolls into view animates once and then stays visible, and that a section visible on load is not left hidden.
- [ ] 10.2 Add the motion tokens (duration, curve, distance) to `DESIGN.md` and honor `MediaQuery.disableAnimations` everywhere; verify no animation runs under reduced motion.
- [ ] 10.3 Add restrained secondary motion: a staggered reveal inside a revealed section and a short slide transition in the presentation; verify with `flutter test` that the staggered items and the transition do not break the existing smoke tests.

## 11. Owner wallpaper

- [ ] 11.1 Export the owner wallpaper `karem-adem-VYhlOMPORj8-unsplash.png` (4000×2182, Karem Adem on Unsplash) into `assets/hero-desktop.webp` (landscape crop) and `assets/hero-mobile.webp` (portrait crop), each under 250 KB; verify both files exist with the expected dimensions and weights, and complete task 4.1.
- [ ] 11.2 Add the localized credit line to the hero and record the asset source and credit in `DESIGN.md`; verify the credit line is visible and legible over the image and that the link opens the Unsplash photo in a new tab.
- [ ] 11.3 Verify the shipped bundle contains only the two hero crops plus the bundled fonts; the legacy images (`banner_background.png`, `font-banner*.jpg`, `photo.jpg`) stay in git but out of the bundle per `design.md`; verify the release build ships no legacy image.
- [ ] 11.4 Sample the pixels behind the name, role, header labels, and hero buttons; verify large text reaches 3:1 and normal text 4.5:1, strengthening the scrim tokens if needed.

## 12. Alternative terminal landing

- [x] 12.1 Add semantic terminal palette tokens and a responsive dark-only terminal window frame with simulated window controls, title, subtle scanlines, and reduced-motion-safe cursor; verify theme and reduced-motion widget behavior.
- [x] 12.2 Add the welcome prompt and accessible navigation tabs for about, skills, projects, certifications, and contact, reusing repository content and preserving language/theme/Medium/CV actions; verify tab selection updates content.
- [x] 12.3 Apply JetBrains Mono to dark navigation and terminal controls, preserve the light-mode composition and original wallpaper brightness, and verify layout at mobile and desktop widths with no horizontal overflow.
- [x] 12.4 Localize experience, project, and certification data plus the terminal status label; arrange GitHub, LinkedIn, and Medium in consistent responsive terminal cards; verify the language switch and equal social-card sizing.
