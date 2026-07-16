# Obsidian — preview card

Use this small file for title-slide previews only. Read `design.md` for full generation.

## Selection metadata
- Slug: `obsidian`
- Tagline: apple.com after dark — every slide true black with subtle depth, monochrome SF Pro, zero accent color. High-end through restraint and space.
- Mood: premium, minimal, restrained, luxurious
- Register: speaker-led · Density: low · Scheme: dark · Formality: high
- Best for: keynotes and brand/vision talks that should feel expensive and considered; design-led, fashion/luxury, executive, or Apple-adjacent audiences.
- Avoid for: hype/launch energy, data-dense reading decks, playful community talks.

## Visual snapshot
A true-black stage (#000) given dimension by a faint radial depth glow, near-white SF Pro
type (#F5F5F7), and a muted gray for support (#8E8E93). There is **no accent color at all** —
the only filled shape in the whole deck is an optional white-pill CTA on the closing slide.
Type is semibold (weight 600, Apple's), a touch smaller than Noir, with acres of negative
space. Each line wears a tiny uppercase eyebrow with a 1px hairline rule above it. A faint
film grain keeps the black cinematic. The look reads as luxury: restraint, air, and craft
instead of effects.

## Preview ingredients
- Palette: stage #000 with a subtle radial (#151515 center → #000 edge); ink #F5F5F7; muted #8E8E93; hairline rgba(255,255,255,.22). No accent hue.
- Typography: SF Pro Display 600 at a generous-but-not-huge scale; SF Pro Text for the hairline-topped uppercase eyebrow and the 400-weight subhead.
- Signature move: one statement per slide, centered, monochrome — emphasis from the line itself, never a colored word.
- Signature move: tiny eyebrow with a centered 1px hairline rule above it; lots of black around everything.
- Signature move: the only color/contrast moment is a white-pill CTA on the close.
- Motion: a single calm fade-rise (~0.9s) per slide; faint grain; nothing else moves.

## Preview rules
- Build exactly one title slide at 1920×1080 inside the fixed stage.
- Use the user's real title/subtitle. Never render the style name, "preview", "Option A", or file paths on the slide.
- Zero accent color on the title slide — the whole look is monochrome restraint. Do not add a glow, gradient, or colored word.
