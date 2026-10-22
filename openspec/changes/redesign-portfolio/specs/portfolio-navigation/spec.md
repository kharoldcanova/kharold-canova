# Spec Delta

## Purpose

Give visitors a stable, legible way to move through the portfolio's five areas and reach profile actions on any viewport.

## ADDED Requirements

### Requirement: Five navigation anchors
The header SHALL expose exactly five primary destinations in this order: Inicio, Sobre mí, Proyectos, Certificaciones, and Contacto. Each destination SHALL scroll to its corresponding section.

#### Scenario: Each anchor reaches its section
- **WHEN** the visitor activates any of the five anchors
- **THEN** the page scrolls to that section and the anchor becomes the active destination

#### Scenario: Order is stable
- **WHEN** the header renders in any locale or viewport
- **THEN** the five destinations keep the same order

### Requirement: Transparent-to-surface header
The header SHALL render transparent with light text while the hero is in view, and SHALL switch to a theme surface background with a 1px bottom border once the page scrolls past the hero.

#### Scenario: At the top of the page
- **WHEN** the scroll position is zero
- **THEN** the header background is transparent and its content uses the over-image text color

#### Scenario: After scrolling
- **WHEN** the visitor scrolls past the hero
- **THEN** the header gains a surface background and a 1px bottom border, and its labels switch to the theme's primary text color

### Requirement: Active destination indication
The header SHALL indicate the current section with a 2px underline in the theme accent color, and SHALL NOT use a filled background pill.

#### Scenario: Scrolling through sections
- **WHEN** the visitor scrolls from Inicio into Proyectos
- **THEN** the Proyectos destination becomes underlined and Inicio returns to its default state

### Requirement: Utility actions
The header SHALL provide a language toggle, a light/dark theme toggle, and a link to the owner's Medium profile. The Medium link SHALL open in a new tab and SHALL be omitted when no profile URL is configured.

#### Scenario: Language toggle
- **WHEN** the visitor activates the language control
- **THEN** the interface switches between Spanish and English and the selected language is reflected in the control

#### Scenario: Theme toggle
- **WHEN** the visitor activates the theme control
- **THEN** the interface switches between light and dark themes

#### Scenario: Medium profile
- **WHEN** a Medium URL is configured and the visitor activates the Medium control
- **THEN** the profile opens in a new tab

#### Scenario: Medium not configured
- **WHEN** no Medium URL is configured
- **THEN** no Medium control is rendered

### Requirement: Responsive drawer parity
Below 1200px width, the header SHALL collapse into a menu control that opens a drawer containing the five destinations and every utility action. Selecting a destination SHALL close the drawer and scroll to that section.

#### Scenario: Mobile drawer
- **WHEN** the viewport is 390px wide and the visitor opens the menu
- **THEN** the drawer shows Inicio, Sobre mí, Proyectos, Certificaciones, Contacto, the language toggle, the theme toggle, the Medium link when configured, and the CV action

#### Scenario: Destination selection
- **WHEN** the visitor selects Proyectos from the drawer
- **THEN** the drawer closes and the page scrolls to Proyectos

### Requirement: Keyboard and focus behavior
Every header and drawer control SHALL be reachable by keyboard, SHALL show a visible focus indicator, and the drawer SHALL close with Escape.

#### Scenario: Keyboard navigation
- **WHEN** the visitor tabs through the header
- **THEN** each control receives a visible focus ring and can be activated with Enter or Space

#### Scenario: Closing the drawer
- **WHEN** the drawer is open and the visitor presses Escape
- **THEN** the drawer closes and focus returns to the menu control
