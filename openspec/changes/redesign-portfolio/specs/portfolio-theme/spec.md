# Spec Delta

## Purpose

Provide a light-first visual theme and an opt-in dark theme that follow the `DESIGN.md` token system consistently across every surface.

## ADDED Requirements

### Requirement: Light theme on first visit
The site SHALL render the light theme on a visitor's first visit, regardless of the operating system color preference.

#### Scenario: First visit on a dark-preference system
- **WHEN** a new visitor loads the site from an operating system set to dark mode
- **THEN** the site renders in the light theme

#### Scenario: First visit on a light-preference system
- **WHEN** a new visitor loads the site from an operating system set to light mode
- **THEN** the site renders in the light theme

### Requirement: Theme toggle
A single theme control SHALL switch between light and dark themes. The control SHALL show the destination theme icon and a localized accessible label.

#### Scenario: Switching to dark
- **WHEN** the visitor activates the theme control in light theme
- **THEN** the site renders the dark theme and the control shows the light-theme destination icon

#### Scenario: Switching back to light
- **WHEN** the visitor activates the theme control in dark theme
- **THEN** the site renders the light theme and the control shows the dark-theme destination icon

### Requirement: Persisted explicit choice
An explicit theme choice SHALL be remembered across reloads and visits. The light default SHALL apply only when no explicit choice has been stored.

#### Scenario: Returning visitor
- **WHEN** a visitor selects dark and reloads the site
- **THEN** the site renders in dark theme without first flashing the light theme

#### Scenario: Cleared preference
- **WHEN** stored preferences are cleared and the site reloads
- **THEN** the site renders the light theme again

### Requirement: Contrast-safe token mapping
Every surface, text, border, and control SHALL use `DESIGN.md` semantic tokens for the active theme. Text on primary buttons SHALL use the documented on-primary value, and the dark accent SHALL never be used as text color.

#### Scenario: Primary button contrast
- **WHEN** the primary button renders in either theme
- **THEN** its label meets WCAG AA contrast against the button background

#### Scenario: Accent in dark theme
- **WHEN** an accent highlight renders in dark theme
- **THEN** the accent is used as a filled surface with a light label, not as text on the page background

### Requirement: Theme coverage across surfaces
Switching theme SHALL update the page body, header, drawer, cards, hero scrim labels, contact block, and footer consistently, with no element retaining the other theme's colors.

#### Scenario: Switching with the drawer open
- **WHEN** the visitor opens the drawer and toggles the theme
- **THEN** the drawer, header, and page update to the new theme together

#### Scenario: No hardcoded colors
- **WHEN** any themed widget renders in either mode
- **THEN** its colors resolve from semantic tokens rather than literal color values

### Requirement: Terminal-inspired dark theme
The dark theme SHALL use a black page background, a green primary accent, JetBrains Mono typography, and terminal-inspired green borders. The light theme SHALL retain its blue primary accent and Poppins typography. Values SHALL be applied through semantic tokens and documented in `DESIGN.md`.

#### Scenario: Dark background depth
- **WHEN** the dark theme renders
- **THEN** the page background is pure black, and the header, drawer, and cards follow a black/green terminal palette

#### Scenario: Contrast preserved
- **WHEN** the dark palette is applied
- **THEN** body text, secondary text, borders, and controls still meet WCAG AA contrast against the new surfaces

#### Scenario: Mode-specific accent
- **WHEN** the visitor switches between light and dark themes
- **THEN** light mode uses the existing blue primary and dark mode uses a green primary consistently across interactive states and the contact section

#### Scenario: Distinct typeface
- **WHEN** the visitor switches between light and dark themes
- **THEN** light mode uses Poppins and dark mode uses JetBrains Mono throughout the interface

#### Scenario: Contact readability
- **WHEN** Contacto renders in dark mode
- **THEN** its background uses the semantic dark contact green and all text is white

### Requirement: Alternative terminal landing in dark mode
The application SHALL render a distinct terminal-inspired landing when dark mode is active while preserving the light-mode portfolio composition. The dark landing SHALL use bundled JetBrains Mono throughout, including navigation, deep dark surfaces, readable light text, and semantic green, cyan, muted-yellow, and magenta accents. A restrained CRT scanline and blinking prompt cursor MAY animate but SHALL honor reduced-motion preferences.

#### Scenario: Dark mode selects terminal landing
- **WHEN** the visitor enables dark mode
- **THEN** the light portfolio layout is replaced by a responsive terminal window titled `kharold@portfolio:~` with simulated red, yellow, and green controls and a `whoami`/`help` welcome prompt

#### Scenario: Terminal section navigation
- **WHEN** the visitor selects a terminal tab
- **THEN** the main output changes to the selected about, skills, projects, certifications, or contact content without horizontal overflow

#### Scenario: Dark navigation typeface
- **WHEN** the dark terminal landing is active
- **THEN** every navigation tab and terminal command uses JetBrains Mono

#### Scenario: Switching the terminal content language
- **WHEN** the visitor switches the terminal landing from Spanish to English
- **THEN** experience roles, locations, and highlights, project descriptions, categories and translated tags, certification titles or subtitles, dates, and the terminal status label appear in English

#### Scenario: Reduced motion terminal effects
- **WHEN** reduced motion is enabled
- **THEN** scanline and blinking-cursor animation is disabled while all terminal content remains visible

#### Scenario: No literal colors outside tokens
- **WHEN** the dark palette changes
- **THEN** the new values live in the theme token file and `DESIGN.md`, and no widget hardcodes a color value
