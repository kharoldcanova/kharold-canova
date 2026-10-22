# Spec Delta

## Purpose

Let a visitor consume the portfolio as a full-screen slide deck, reusing the exact content and order of the five anchors without changing the scrolling page.

## ADDED Requirements

### Requirement: Presentation entry point
The header SHALL expose a presentation control that starts the presentation mode, and the mobile drawer SHALL expose the same destination. The control SHALL show a play affordance and a localized accessible label.

#### Scenario: Header control on desktop
- **WHEN** a visitor views the header at 1440px
- **THEN** a play control labeled with the localized presentation-mode label is visible next to the other utility controls

#### Scenario: Drawer parity on mobile
- **WHEN** a visitor opens the drawer at 390px
- **THEN** the drawer exposes a presentation entry that starts the same presentation mode

### Requirement: Slide-based presentation
The presentation SHALL render the portfolio content as one full-viewport slide per section, in the same order as the page (hero, about, knowledge, projects, certifications, contact), and SHALL reuse the same section widgets as the scrolling page.

#### Scenario: First slide
- **WHEN** the presentation opens
- **THEN** the first slide shows the hero identity block and the position indicator reads "1 / 6"

#### Scenario: Shared content
- **WHEN** a slide renders
- **THEN** its content comes from the same widget the scrolling page renders and no duplicated copy of the content exists

#### Scenario: Anchor parity
- **WHEN** the presentation advances through its slides
- **THEN** each slide corresponds to one of the five navigation anchors, in the same order as the header

### Requirement: Slide navigation
The presentation SHALL support next and previous navigation through on-screen controls, arrow keys, and the space bar, SHALL show the current position, and SHALL close on Escape.

#### Scenario: Keyboard navigation
- **WHEN** the presentation is open and the visitor presses the right arrow
- **THEN** the next slide becomes visible and the position indicator increments

#### Scenario: Closing
- **WHEN** the visitor presses Escape
- **THEN** the presentation closes and the page returns to the scroll position it had before opening

#### Scenario: Last slide
- **WHEN** the visitor is on the last slide and activates next
- **THEN** the presentation stays on the last slide

### Requirement: Presentation responsiveness and theming
The presentation SHALL adapt each section into a screen-sized card between 360px and 1920px without scrolling inside a slide, SHALL follow the active light or dark theme, SHALL avoid horizontal overflow, and SHALL honor the reduced-motion preference.

#### Scenario: Reduced motion
- **WHEN** the platform requests reduced motion
- **THEN** slide transitions render without motion and every slide stays fully readable

#### Scenario: Dark theme
- **WHEN** the visitor switches to the dark theme while the presentation is open
- **THEN** the presentation updates to the dark theme tokens
