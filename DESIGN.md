# Firefly Design Language

## Core Idea

Firefly is a dark glass theme inspired by the character from Honkai Star Rail, built around vibrant cream/off-white accents, deep black structural tones, and teal-green highlights. Rounded glass surfaces with luminous quality and flowing forms capture her energetic essence.

It should feel:

- vibrant
- energetic
- futuristic
- bold, but not overwhelming
- stylized, yet still readable

The theme is not meant to be pastel-cute or dark and brooding. Its identity comes from using cream/off-white as the vibrant energy and deep black as the grounding frame, with teal-green accents representing her hair tips, gems, and detailing.

## Visual Voice

The voice of the theme is:

- vibrant cream/off-white for energy, focus, and vitality (representing her silvery-blonde hair and skin)
- deep black structural tones for shape, depth, and grounding (representing her dress, stockings, and blazer)
- near-black base for contrast and intensity
- soft translucency with luminous quality instead of flat panels
- rounded, flowing forms inspired by her long hair
- teal-green and soft steel accents for vitality and detail (representing her hair tips, dress gems, and collar detailing)

If a surface becomes only cream/off-white, the theme loses depth.
If a surface becomes only dark, the theme loses vitality.
The theme works when vibrant cream/off-white and deep black are both present, with teal-green accents, creating her distinctive energy.

## Source Of Truth

`colors.toml` is the canonical palette source for this theme.

That means:

- every documented color value should match `colors.toml`
- derived CSS aliases and app-specific mappings should follow `colors.toml`, not invent parallel palette truth
- if a component needs translucency, gradients, or mixed states, those effects should still be built from the `colors.toml` palette
- when the palette changes, `colors.toml` should be updated first and the rest of the theme should be reconciled to it

## Palette Roles

All color choices in this theme should be authored with perceptual color reasoning in mind, using Oklab/Oklch as the design model even though the shipped files store hex values.

That means:

- perceived lightness should stay intentional across accents and support colors
- saturation changes should preserve role clarity instead of relying on arbitrary HSL-style tweaking
- cream/off-white and teal-green should feel balanced by eye because their lightness and chroma were chosen perceptually

### Core Neutrals

- Background: `#000000` (`background`, `color0`) - true black
- Raised lacquer surface: `#4D5F64` (`lighter_bg`) - blue-teal from eyes and detailing
- Deep structural teal-brown: `#6F9C97` (`dark_fg`) - medium teal-green for structure
- Readable muted teal: `#6F9C97` (`muted`, `color8`) - medium teal-green for text
- Primary foreground cream: `#BAC8B1` (`foreground`, `color5`, `color7`) - cream/off-white for hair and skin tones

### Primary Accent System

- Primary focus soft steel: `#8FA4AB` (`accent`, `active_border_color`, `selection_background`, `color1`) - soft steel for hair tips and accents
- Primary foreground cream: `#BAC8B1` (`foreground`, `color5`) - cream/off-white for main text
- Soft living teal: `#6F9C97` (`color2`) - medium teal-green for support elements
- Bright electric teal: `#6F9C97` (`color4`) - medium teal-green for highlights
- Secondary cool support teal: `#4D5F64` (`color6`) - blue-teal for inactive elements
- Bright support teal: `#6F9C97` (`color10`) - medium teal-green for active support
- Pale support teal-green: `#8FA4AB` (`color14`) - soft teal-green for subtle accents

### Supporting Light Tones

- Warm cream: `#BAC8B1` (`foreground`, `color5`, `color7`) - cream/off-white for warmth and primary text
- Bright cream: `#BAC8B1` (`foreground`) - cream/off-white for brightness (same as warm cream in this theme)
- Light shell cream: `#BAC8B1` (`soft_fg`, used only for hand-tuned secondary text) - tinted cream/off-white for subtle text
- Bright shell teal: `#8FA4AB` (`color1`) - soft steel for shell details and accents
- Bright white-cream: `#BAC8B1` (`foreground`) - cream/off-white for maximum brightness (same as warm cream)

### Semantic Intent

- Cream/off-white carries active states, focus, selected surfaces, and visual charm (hair, skin, energy)
- Teal-green carries support structure, troughs, inactive framing, and atmosphere (hair tips, gems, detailing)
- Deep teal-brown carries depth, contrast, and the lacquered body of the interface (dress, stockings, blazer)
- Blue-teal accents stay secondary and should not dominate the shell language (eyes, subtle detailing)

## Surface Language

The shell should read as tinted glass over a dark lacquer base.

Rules:

- Panels should usually be dark and translucent, not fully opaque.
- Borders should be cream/off-white-tinted and partially transparent rather than loud solid outlines.
- A light green tint can be introduced inside panels to keep the palette dual-toned.
- Shadows should be soft and grounding, not sharp or theatrical.
- Surfaces should feel cushioned and rounded, not boxed in.

The ideal read is not "green panel on black background."
The ideal read is "dark glass panel catching cyan and green light."

## Border Language

Borders are one of the defining features of the theme.

The border style should be:

- soft
- cream/off-white-tinted
- translucent
- rounded
- visible enough to define shape without turning into chrome

Preferred treatment:

- use cream/off-white borders at partial opacity for primary shell surfaces
- use teal-green as a support or inactive border color, not the main frame everywhere
- avoid pure hard white borders
- avoid fully saturated solid cream/off-white borders unless the surface is intentionally highlighted

## Shape Language

Rounded corners are part of the identity.

The theme should prefer:

- medium rounding instead of extreme pill shapes
- consistent radius relationships across shell surfaces
- softer silhouettes for windows, panels, OSDs, and popovers

Rounding values should be chosen by role, not locked to one universal number.

The system should follow a proportional scale so related surfaces feel mathematically related rather than arbitrarily rounded.

Practical rule:

- use one base radius for the context
- derive nearby radii as simple multiples or near-multiples of that base such as `1x`, `1.25x`, `1.5x`, or `2x`
- larger containers should usually have larger radii than the controls they contain
- nested elements should usually step down in radius rather than matching the outer shell exactly
- pill shapes are allowed for progress bars, sliders, and chips when the component logic calls for it

Examples of good proportional relationships:

- a major shell can sit around `20-24px` while its internal fields and rows sit around `14-16px`
- a window shell can sit around `14px` while smaller child controls inherit lower values in the same ratio family

The rounding should feel soft and polished, not bubbly or toy-like.

## Motion Language

Motion should feel like soft drift through tinted glass.

Animation should be:

- smooth
- slightly buoyant
- calm on workspace changes
- more plush than snappy
- present, but not attention-seeking

Avoid:

- harsh mechanical easing
- exaggerated elastic bounce
- fast aggressive slides
- flashy border-angle spectacle as a default identity

The intended motion metaphor is lacquer and glass, not chrome and machinery.

## Wallpaper Relationship

The wallpaper set is vivid, graphic, and high-contrast. Many images carry strong cream/off-white and green interplay with black depth.

That means the shell should not compete with the wallpapers by becoming louder than them.

Instead, the UI should:

- borrow the cream/off-white/green relationship
- simplify the values
- darken the base
- blur and soften what the wallpapers express more aggressively

The wallpaper can be loud.
The interface should be composed.

## Contrast Strategy

Readability matters, but this theme should not solve readability by flattening everything into hard high-contrast blocks.

Preferred strategy:

- dark base for legibility
- pale cream/off-white text on dark surfaces
- cream/off-white for key emphasis
- green for supporting structure
- translucent borders and shadows to separate layers

Do not overuse:

- full-opacity accent fills
- bright greens on large surfaces
- white text everywhere
- solid outlines when a translucent one will do

## Component Guidance

### Hyprland

- rounded windows
- soft translucent borders
- cream/off-white active border
- green inactive support border
- blur that preserves separation instead of color-smearing the wallpaper

### Waybar

- grouped dark glass modules
- cream/off-white border language
- subtle green interior tint
- restrained highlight usage

### SwayOSD

- dark floating glass panel
- cream/off-white frame
- green support in the icon or trough
- cream/off-white progress fill

### Notifications and Launchers

- same border logic as the rest of the shell
- same rounded silhouette
- same cream/off-white/green balance
- green should remain visible as a support cue in at least one structural element such as a tint, icon treatment, trough, hover edge, or internal frame
- no accidental fallback to flat monochrome boxes

## What To Preserve

When iterating on this theme, preserve these invariants:

- true black base
- cream/off-white and green both visible in the shell
- cream/off-white as the emotional lead
- green as the structural counterweight
- translucent cream/off-white borders
- medium rounding
- soft glass depth
- calm plush animation

## What To Avoid

Avoid changes that push the theme into these directions:

- pure pastel kawaii
- pure neon cyberpunk
- sharp monochrome minimalism
- hard-edged industrial brutalism
- cream/off-white-only surfaces with no green balance
- green-only restraint that erases the theme's sweetness

## Release Review Checks

Before calling an Omarchy theme release-ready, review the terminal configs as a set instead of one file at a time.

Required check:

- terminal opacity settings should be unified across all terminal configs that support explicit opacity values
- for this theme, that means `foot.ini`, `kitty.conf`, `ghostty.conf`, and `alacritty.toml` should agree on the same effective background opacity
- if one terminal cannot express the same setting in its shipped theme format, that exception should be noted explicitly instead of leaving the mismatch silent

## One-Sentence Test

If a new surface looks like dark glass with cream/off-white energy and green/cyan support underneath, it belongs to Firefly.
