# portfolio-cv-redesign
Objective: align the portfolio with the main CV and redesign it as a minimal blue site whose signature is an NL→SQL project finder.
Branch: refactor/design-calm-theme · Delivery: ask-on-risk · Test runner: `flutter test` (+ `flutter analyze`)

## Specs
- S1 Content matches the main CV (`ai-job-search/cv/main_example.tex` and `main_example_en.tex`): summary, experience, key skills, projects in CV order, education, certifications, availability and languages.
- S2 "lo que no me gusta es el modo oscuro en terminal, opaca el contenido, el modo presentacion es demasiado": dark mode is the same page with a dark palette; the presentation mode is removed; the terminal stays only as an easter egg (footer `>_` icon and keyboard shortcut).
- S3 "los botones creo que estan mal ubicados": the header holds only nav, ES/EN, the theme toggle and a `CV` button; GitHub, LinkedIn and Medium move to text links in the hero, contact and footer; no floating social rail.
- S4 "propuesta de diseño minimalista pero decente, conservando el color azul": single blue accent (`#0033CC` light / `#8AA8FF` dark), plain background, subtle borders, whole-card links, Poppins only, monospace only for SQL.
- S5 (rev. L13) Hero signature = animated neural networks (Visión · LAIN MiniCPM-V, Voz · LAIN Kokoro, Texto → SQL · ia-sql Ollama) that wake up under the pointer/tap; stacked rows on phones; static with reduced motion. The NL→SQL finder is dropped. Copy follows the mockup v5 voice (first person, natural); "Disponibilidad inmediata" pill in hero and contact; location/languages as a quiet line under contact.
- S6 Small circular photo (`assets/photo.jpg`) in About me with a metrics strip (4 años · ~115 usuarios activos · 2 tiendas · 3 años remoto con EE.UU.).
- S7 Mockup first: an HTML artifact the user approves before the Flutter redesign (T2+).
- S9 Responsive: every section and the hero widget work at phone width (~390px).
- S8 No push or merge to `main` without the user's approval of screenshots.

## Tasks
- [x] T1 S1 inline: content restructure, commit 785cf4c
- [x] T0 S7 inline: mockup approved at v5 (https://claude.ai/artifact/2cp73a8bxtGTKdNXspLbYN)
- [x] T2 S2,S3 inline: remove presentation; header/drawer/footer actions; terminal easter egg in footer + ` shortcut
- [x] T3 S5,S9 inline: NeuralNetworks widget (CustomPainter) + hero rewrite
- [x] T4 S4,S6,S9 inline: About photo/metrics, experience, projects, skills, contact restyle + natural copy ES/EN
- [x] T5 S2-S9 inline: DESIGN.md / AGENTS.md, tests, screenshots light/dark 390/1440 · T2-T4 in b222452, T5 docs in 81811b0

## Log
- L1 (2026-11-25) user: "Necesito reestructurar el contenido de la pagina  de acuerdo al CV principañ puesto en ai-job-search. Despues rediseñar en su totalidad la pagina para un portafolio decente: lo que no me gusta es el modo oscuro en terminal, opaca el contenido, el modo presentacion es demasiado. Analiza tu el contenido, los botones creo que estan mal ubicados, necesito que analizas y lances una propuesta de diseño minimalista pero decente, conservando el color azul. Pero quiero mantener creatividad en mi portafolio, segun mi personalidad que me recomiendas?"
- L2 (2026-11-25) decisions: signature = NL→SQL finder; terminal only as easter egg; small photo in About me.
- L3 T1: analyze clean, 80/80 tests passing; branch already contained origin/main (no rebase needed). Committed 785cf4c.
- L4 T0: mockup v1 published as a private artifact https://claude.ai/artifact/2cp73a8bxtGTKdNXspLbYN; the Flutter redesign (T2+) waits for user approval.
- L5 (2026-11-25) user: "Me gusta, pero necesitamos que el contenido sea coherente pero menos robotico, existen algunas palabras como disponibilidad inmediata, tiempo completo o asi, una persona real no pondria cosas asi en su portafolio, lo mismo en ciertas palabras de preguntale a mi portafolio, prepara una nueva version con lo que te comente."
- L6 T0: mockup v2 published with first-person copy (no "disponibilidad inmediata", "tiempo completo" or "Pregúntale a mi portafolio"); facts unchanged from the CV. When implementing, the .arb copy must follow the v2 voice, not the CV wording. Awaiting approval.
- L7 (2026-11-25) user: "Sigue sin convencerme, lo de Vivo en Piura...., podriamos ponerlo como en otra seccion? o en alguna otra parte? no necesariamente tiene que destacar. Tambien lo de pasar a sql , ese widget, dame otras opciones"
- L8 T0: mockup v3: the location/languages line moved out of About to a quiet line under the contact links; the hero widget has 4 switchable options (A SQL finder, B what I am working on, C mm2 pipeline, D LAIN demo). S5 is on hold until the user picks one.
- L9 (2026-11-25) user: "Un poco mejor, Pon en algun lugar Disponibilidad Inmediata, respecto al widget, todavia tengo mis dudas, algo mas novedoso? Tambien recuerda que el portafolio debe ser compatible con responsive mobile"
- L10 T0: mockup v4: a "Disponibilidad inmediata" pill in the hero eyebrow and above "Hablemos"; new widget options 1 problem→how I solved it, 2 your time vs mine (Piura UTC−5, workday overlap), 3 KC particles, plus B for reference. Checked with headless Chromium at 390px and 1440px; fixed the CV button wrap, the theme icon and chip alignment on mobile. New requirement S9: everything must work on mobile.
- L11 (2026-11-25) user: "Puedes hacer una animacion de varias  redes neuronales que cambie al pasar el cursor?"
- L12 T0: mockup v5: option 4 = three canvas networks (Visión · LAIN MiniCPM-V, Voz · LAIN Kokoro, Texto → SQL · ia-sql) that wake up under the pointer: pulses speed up, nodes light up and lean toward the cursor. On phones they stack in rows and react to taps. Static with reduced motion. Checked at 390px and 1440px. Flutter port would use CustomPainter + Ticker + MouseRegion/Listener.
- L13 (2026-11-25) user: "Me gusta lo de las redes neuronales, bien entonces tenemos este plan, hagamoslo"
- L14 T2-T5: implemented inline; flutter analyze clean, 74/74 tests (new: hover/rest ticker, phone tap burst, reduced motion, copy email, backquote shortcut, 8 widths x 2 themes without overflow). Release-build screenshots light/dark at 1440 and 390 reviewed; fixed the clipped phone label, header gutter and heavy borders. Pending: user approval of screenshots before merge/push (S8).
