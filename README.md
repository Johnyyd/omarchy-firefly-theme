# Omarchy Firefly Theme

Firefly is a dark Omarchy theme inspired by the character from Honkai Star Rail, featuring vibrant cream/off-white accents against a true black background, with teal-green structural tones and highlights. Rounded glass surfaces with luminous quality and flowing forms capture her energetic essence.

## Preview

![Firefly preview](preview.png)

## Install

For a complete install with automatic backups and an uninstall path, run:

```bash
./install.sh
```

The installer copies every project configuration file into the Firefly theme,
then applies it through Omarchy. It backs up the complete previous Firefly
theme, generated runtime theme, wallpaper, Kitty template, and VS Code settings.
It also installs the generated Firefly VS Code color extension through Omarchy.
Restore everything with:

```bash
./uninstall.sh
```

For the standard Omarchy theme installer:

```bash
omarchy-theme-install https://github.com/Johnyyd/omarchy-firefly-theme
```

## What's Included

- Native Omarchy Quattro theming through `colors.toml`, `shell.toml`, and `hyprland.lua`, including shared cream/off-white-tinted/ border gradients, shell surfaces, controls, spacing, and typography.
- Omarchy 3.8 compatibility styling for Hyprland, Hyprlock, Waybar, Mako, Walker, and SwayOSD.
- Current terminal and editor mappings for Alacritty, Foot, Ghostty, Kitty, Helix, Pi, VS Code, Zed, Warp, and Neovim.
- A standalone [Vencord theme](vencord.theme.css) with its own layered Discord treatment instead of a thin palette pass-through.
- A custom [Neovim theme override](neovim.lua) for `bjarneo/aether.nvim` with Firefly-specific highlight tuning.

## Wallpapers

<table>
  <tr>
    <td><img src="backgrounds/0-firefly.jpg" width="220" alt="Firefly"></td>
    <td><img src="backgrounds/1-firefly.jpg" width="220" alt="Firefly"></td>
    <td><img src="backgrounds/2-firefly.jpg" width="220" alt="Firefly"></td>
  </tr>
  <tr>
    <td><img src="backgrounds/3-firefly.jpg" width="220" alt="Firefly"></td>
    <td><img src="backgrounds/4-firefly.jpg" width="220" alt="Firefly"></td>
    <td><img src="backgrounds/5-firefly.jpg" width="220" alt="Firefly"></td>
  </tr>
  <tr>
    <td><img src="backgrounds/6-firefly.jpg" width="220" alt="Firefly"></td>
    <td><img src="backgrounds/7-firefly.jpg" width="220" alt="Firefly"></td>
    <td><img src="backgrounds/8-firefly.jpg" width="220" alt="Firefly"></td>
  </tr>
</table>

### Animated Wallpapers

The `backgrounds/` directory also includes six optimized 4K H.264 loops for setups that support animated wallpapers. Their original 3840×2160 resolution and frame rates are preserved.

Omarchy Quattro's built-in background picker currently selects static image formats only, so these videos are intentionally shipped as optional assets for an animated-wallpaper tool such as `mpvpaper`. They do not replace the static wallpapers or interfere with normal theme switching.

## Requirements

- Omarchy 4.0 (Quattro) for native shell and Hyprland Lua treatment
- `Yaru-prussiangreen` icon theme
- Optional animated-wallpaper renderer for the bundled MP4 loops
