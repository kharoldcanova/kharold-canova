# Spec Delta

## Purpose

Present the owner's identity over a full-viewport illustration while keeping the CV and contact actions immediately reachable, without a portrait image.

## ADDED Requirements

### Requirement: Full-viewport illustrated hero
The landing section SHALL occupy the full viewport height, display the owner-supplied illustration as a full-bleed background, and SHALL NOT render a portrait or avatar image.

#### Scenario: First load on desktop
- **WHEN** a visitor loads the site at 1440x900
- **THEN** the hero fills the viewport with the illustration and shows no portrait image

#### Scenario: Mobile viewport
- **WHEN** a visitor loads the site at 390x844
- **THEN** the hero fills the viewport with a portrait-appropriate crop and shows no portrait image

### Requirement: Identity block
The hero SHALL display the name "Kharold Canova" at 80px on desktop and 36px on mobile, and the localized role at 38px on desktop and 20px on mobile.

#### Scenario: English locale
- **WHEN** the site renders in English
- **THEN** the hero shows "Kharold Canova" and the English role string at the specified sizes

#### Scenario: Spanish locale
- **WHEN** the site renders in Spanish
- **THEN** the hero shows the Spanish role string at the specified sizes and the name unchanged

### Requirement: Hero actions
The hero SHALL provide a primary action that opens the current CV PDF in a new browser tab and a secondary action that navigates to the contact section.

#### Scenario: Download CV
- **WHEN** the visitor activates the CV action
- **THEN** the current CV PDF opens in a new browser tab

#### Scenario: Contact action
- **WHEN** the visitor activates the secondary action
- **THEN** the page scrolls to the contact section and marks Contacto as active

### Requirement: Original wallpaper appearance
The light-mode wallpaper SHALL render at its original brightness without a scrim, opacity animation, or hover treatment. Hero text and controls SHALL remain positioned for legibility without modifying the wallpaper.

#### Scenario: Original image brightness
- **WHEN** the light-mode hero renders
- **THEN** the supplied image is shown without a darkening overlay or opacity animation

#### Scenario: Header over the image
- **WHEN** the page is at the top and the header is transparent
- **THEN** the header retains its existing light labels and icons without changing the image brightness

### Requirement: Responsive hero composition
The hero SHALL place the identity block over a calm area of the illustration and SHALL NOT overflow, clip, or force horizontal scrolling between 360px and 1920px widths.

#### Scenario: Narrow viewport
- **WHEN** the viewport is 360px wide
- **THEN** the name, role, and actions fit without clipping or horizontal scroll

#### Scenario: Wide viewport
- **WHEN** the viewport is 1920px wide
- **THEN** the identity block stays aligned to the content grid rather than stretching across the full width

### Requirement: Mode-aware hero background
In light mode, the hero SHALL render the supplied wallpaper as a decorative desktop landscape crop and a mobile portrait crop, both stored as WebP within the agreed weight budget. In dark mode, the hero SHALL use a solid black background and SHALL NOT load an image. The UI SHALL NOT identify who owns or created the image, link to its source, or apply hover treatment to the background image.

#### Scenario: Desktop crop
- **WHEN** the hero renders at 1440px
- **THEN** the landscape WebP crop fills the hero with `BoxFit.cover` and weighs no more than 250 KB

#### Scenario: Mobile crop
- **WHEN** the hero renders at 390px
- **THEN** the portrait WebP crop fills the hero and weighs no more than 250 KB

#### Scenario: Dark theme background
- **WHEN** the hero renders in dark mode
- **THEN** it uses a solid black background without loading either wallpaper image

#### Scenario: Image background has no attribution or hover treatment
- **WHEN** the hero renders
- **THEN** no image ownership or author attribution is shown and moving the pointer over the background does not change it

#### Scenario: Documented presentation
- **WHEN** the wallpaper is committed
- **THEN** `DESIGN.md` documents that the wallpaper is decorative and uncredited in the UI
