# Spec Delta

## Purpose

Organize the portfolio's non-hero content into a coherent, restrained sequence that presents the owner's background, knowledge, projects, certifications, and contact details.

## ADDED Requirements

### Requirement: Section sequence
The page SHALL present its sections in this order: hero, Sobre mí, Proyectos, Certificaciones, Contacto, and footer. Sobre mí SHALL contain the knowledge sub-block so that no separate Servicios section exists.

#### Scenario: Full page order
- **WHEN** the visitor scrolls from top to bottom
- **THEN** the sections appear in the specified order and no Servicios section appears

#### Scenario: Sobre mí contains knowledge
- **WHEN** the visitor reaches Sobre mí and continues scrolling through it
- **THEN** the bio, experience stats, professional experience timeline, grouped technical stack, and Conocimientos cards are all part of that region

### Requirement: About content
Sobre mí SHALL present the owner's biography, experience statistics, a professional experience timeline, and a grouped technical stack. The knowledge sub-block SHALL present six capability cards covering mobile, web, backend/automation, DevOps, generative AI, and scripting.
Portfolio biography, employment, skills, projects, and certifications SHALL reflect the latest owner-provided CV-portafolio PDF in Downloads. Projects identified there as internal SHALL NOT be presented as public repositories.

#### Scenario: Biography and statistics
- **WHEN** Sobre mí renders
- **THEN** it shows the localized biography and the experience statistics derived from the portfolio data

#### Scenario: Professional experience
- **WHEN** the visitor reaches the experience timeline
- **THEN** each role shows its period, role, company, location, and impact highlights

#### Scenario: Technical stack
- **WHEN** the visitor reaches the technical stack
- **THEN** it shows grouped technology chips with no numeric levels, percentages, or radar chart

#### Scenario: Knowledge cards
- **WHEN** the visitor reaches the Conocimientos sub-block
- **THEN** six capability cards render with an icon and a localized label

### Requirement: Featured published skill
Proyectos SHALL show a featured card for the owner's published skill before the project grid when a published-skill entry is configured. The card SHALL include the skill name, a short description, and a link or install command. When no entry is configured, no empty placeholder SHALL render.

#### Scenario: Published skill configured
- **WHEN** a published-skill entry exists
- **THEN** the featured card renders above the project grid and its link opens the skill destination

#### Scenario: Published skill not configured
- **WHEN** no published-skill entry exists
- **THEN** the project grid renders without a featured card or empty space reserved for one

### Requirement: Project cards
Each project card SHALL show the project title, description, and technology stack without requiring hover. Project cards SHALL use a 1px border and SHALL NOT use drop shadows.
Every project card SHALL use the same rendered width and height at a given responsive breakpoint; long descriptions SHALL be constrained rather than distorting individual cards.

#### Scenario: Reading a project
- **WHEN** the visitor views the project grid
- **THEN** every card shows its description and technology tags immediately

#### Scenario: Uniform project card dimensions
- **WHEN** project cards render together at the same viewport width
- **THEN** each card has the same width and height while text remains contained within the card

#### Scenario: Pointing at a card
- **WHEN** the visitor hovers or focuses a project card
- **THEN** the border changes to the theme accent color and no shadow appears

### Requirement: Certifications destination
Certificaciones SHALL be a navigation destination with a heading, a short description, and every certification from the portfolio data, showing brand, title, and date. Certification iconography SHALL use the theme palette rather than arbitrary per-item colors.

#### Scenario: Reaching certifications
- **WHEN** the visitor activates the Certificaciones anchor
- **THEN** the page scrolls to a section that lists all certifications with brand, title, and date

#### Scenario: Theme change
- **WHEN** the theme switches while Certificaciones is visible
- **THEN** the section adopts the new theme colors without any certification keeping a fixed color

### Requirement: Contact and footer
Contacto SHALL present the owner's email and phone as actionable items and the available social profiles. In light mode it uses a theme-primary inverted surface; in dark mode it uses a `#166534` terminal surface with white text. The email action SHALL open a Gmail compose page in a new browser tab; it SHALL NOT invoke the desktop mail handler. The footer SHALL show the copyright notice and social links above a 1px top border, without a solid accent background.

#### Scenario: Contact actions
- **WHEN** the visitor activates the email or phone item
- **THEN** Gmail opens a compose page in a new tab with the owner's email prefilled, while the phone action opens the telephone handler

#### Scenario: Contact palette
- **WHEN** the contact section renders in either theme
- **THEN** light mode uses the theme primary with on-primary text, while dark mode uses `#166534` with white text

#### Scenario: Footer appearance
- **WHEN** the footer renders in either theme
- **THEN** it uses the page background with a 1px top border and no filled accent background

### Requirement: Layout and section headers
Content SHALL be constrained to a 1200px maximum width, centered, with 24px side gutters below 1200px and 80px at or above it. Each section SHALL use a 12px monospace eyebrow and a 32px heading, aligned to the content grid, and SHALL NOT overflow horizontally between 360px and 1920px.

#### Scenario: Section heading
- **WHEN** any content section renders
- **THEN** it shows a monospace eyebrow and a 32px heading aligned with the content grid

#### Scenario: Small viewport
- **WHEN** the viewport is 360px wide
- **THEN** sections use 24px gutters and no section forces horizontal scrolling
