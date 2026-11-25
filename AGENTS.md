# AGENTS.md

Flutter Web-only personal portfolio. There are no Android/iOS/desktop targets; `web/` is the only platform directory.

## Commands

Run from the repository root:

```bash
flutter pub get
flutter gen-l10n          # required after editing lib/l10n/*.arb
flutter analyze
flutter run -d chrome
flutter build web --release --base-href "/"
```

CI order (`.github/workflows/deploy.yml`): `flutter pub get` -> `flutter gen-l10n` -> `flutter build web --release --base-href "/"`. Pushing to `main`/`master` publishes `build/web` to the external `kharoldcanova/kharoldcanova.github.io` repo using `TARGET_REPO_TOKEN`. Do not change the base href without checking that deployment target.

## Architecture

- Single-page app. `lib/main.dart` wires `LanguageBloc` and `ThemeBloc` into `MaterialApp`; the only screen is `lib/screens/portfolio_page.dart`.
- Navigation is in-page anchors, not named routes. `PortfolioPage` owns `GlobalKey`s plus a `ScrollController`; the header and drawer call its `onSectionTap`. Add a section by adding a key and wiring both navigation surfaces.
- The hero's signature is `NeuralNetworksPanel` (`lib/screens/widgets/neural_networks.dart`): a `CustomPainter` driven by a `Ticker` that only runs while something moves, so `pumpAndSettle` still settles in widget tests. Keep it that way: never add an always-running animation. There is no presentation mode; the terminal is an easter egg (footer `>_` or the `` ` `` key).
- UI lives in `lib/screens/widgets/`, theme in `lib/config/theme/`, and content/data in `lib/data/`. `PortfolioRepository` is instantiated directly and all content is hardcoded; there is no backend or HTTP client.
- `DESIGN.md` is the design source of truth. Use the semantic tokens in `BrandColors`/`BrandTheme`; do not add literal colors, shadows, or new radii in widgets.
- The app opens in Spanish (`LanguageState` defaults to Spanish) and supports `en`/`es`. Localization uses `lib/l10n/app_*.arb` with `synthetic-package: false`; generated `app_localizations*.dart` files are checked in. Never edit generated l10n files by hand.
- There is no `build_runner`/freezed setup; l10n is the only code generation in the project.

## Gotchas

- Only `assets/profile.jpg` (320px) and the fonts are bundled; the other images in `assets/` are unused. Assets are declared in `pubspec.yaml`; large images directly inflate the web bundle. Check the `flutter build web` output size before adding assets.
- `web/` files are served as-is (CV PDF, `index.html`, `manifest.json`) and are not part of the Flutter asset bundle. `analysis_options.yaml` excludes `web/**`.
- `README.md` is still the default Flutter stub; use `DESIGN.md` and this file for project context.
- Add tests under `test/`. Widget tests must provide `AppLocalizations.delegate` and the global localization delegates because widgets call `AppLocalizations.of(context)!`.
- OpenSpec is configured in `openspec/`. Changes live under `openspec/changes/<name>/`; use `openspec status --change <name> --json` and `openspec validate <name> --strict` instead of guessing state. The apply workflow is `.opencode/commands/opsx-apply.md`.
