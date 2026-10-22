# Spec Delta

## Purpose

Restore the scroll-triggered reveal that the redesign removed and add restrained motion that reinforces hierarchy while respecting the token-only, no-shadows design rules.

## ADDED Requirements

### Requirement: Scroll-triggered section reveal
Section content SHALL animate into view when it enters the viewport, using a fade and a short upward translation, and SHALL remain fully visible afterwards.
The numeric values in the Impact section SHALL count up when the section becomes visible, so the animation is not spent before the visitor reaches it.

#### Scenario: Section enters the viewport
- **WHEN** a section scrolls into view for the first time
- **THEN** its content fades in and rises into place once and then remains visible

#### Scenario: Section already in view on load
- **WHEN** the page loads with a section already visible
- **THEN** that section is visible immediately and is not left hidden

### Requirement: Reduced motion
All motion SHALL be disabled when the platform requests reduced motion; content SHALL render in its final state without transform or long fades.

#### Scenario: Reduced-motion platform
- **WHEN** the platform requests reduced motion
- **THEN** no reveal, transition, or staggered animation plays and every element is readable

### Requirement: Token-driven motion
Animation durations, curves, and distances SHALL use documented motion tokens, and animations SHALL NOT introduce shadows or literal colors.

#### Scenario: No new visual rules
- **WHEN** an animation runs
- **THEN** it changes only opacity, transform, or border color and uses values declared in `DESIGN.md`

### Requirement: Presentation and theme transitions
The presentation SHALL transition between slides with a short motion, and the theme switch SHALL interpolate between palettes instead of snapping.

#### Scenario: Theme switch
- **WHEN** the visitor toggles the theme
- **THEN** surfaces and text interpolate to the new palette over a short transition
