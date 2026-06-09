# Terminal — preview card

Use this small file for title-slide previews only. Read `design.md` for full generation.

## Selection metadata
- Slug: `terminal`
- Tagline: GitHub-dark stage, terminal green, all mono. A live coding session that learned stagecraft.
- Mood: technical, focused, underground, precise
- Register: speaker-led · Density: low-medium · Scheme: dark · Formality: low
- Best for: dev-tool launches, security talks, API demos, hackathons, infra postmortems.
- Avoid for: non-technical audiences, executive/board settings, anything warm-and-fuzzy.

## Visual snapshot
A GitHub-dark stage (#0D1117) where everything is monospace and the only color is
terminal green (#39D353) with a rare amber warning (#D29922). Headlines read like
commands; kickers read like comments (`# the premise`); the cursor blinks. Restraint
plus the credibility of a tool that lives where the audience lives: the terminal.

## Preview ingredients
- Palette: bg #0D1117; panel #161B22; ink #E6EDF3; muted #8B949E; green #39D353; amber #D29922 (warnings only).
- Typography: JetBrains Mono everywhere — display 800, body 400.
- Signature move: kicker styled as a code comment (`# one idea per slide`), headline as a command or output line.
- Signature move: a blinking block cursor (▮) after the title headline.
- Signature move: green is the only accent; amber appears at most once per deck as the "warning" beat.
- Sound (if enabled): soft mechanical tick on beats, a single square-wave chime on the hero number.

## Preview rules
- Build exactly one title slide at 1920×1080 inside the fixed stage.
- Use the user's real title/subtitle. Never render the style name, "preview", "Option A", or file paths on the slide.
- Everything monospace; if a font other than mono appears, it's not Terminal.
