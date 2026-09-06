# Firefly Theme Conversion Plan

## Overview
This plan outlines the conversion of the Omarchy theme to use the Firefly theme colors from Honkai Star Rail:
- Background: #000000 (53,49,60) - deep black
- Foreground: #BAC8B1 (186,200,177) - cream/off-white
- Accent: #8FA4AB (143,164,171) - soft steel
- Color 4: #6F9C97 (111,156,151) - medium teal-green
- Color 2/3: #4D5F64 (77,95,100) - blue-teal

## Completed Work
Background agents have already processed:
- Tasks T6-T13: helix.toml, hyprland.conf, hyprland.lua, hyprlock.conf, kitty.conf, mako.ini, neovim.lua, obsidian.css
- Tasks T1-T5: aether.override.css, aether.zed.json, ghostty.conf, gtk.css, gum_env.lua (files updated but verification logic issue)

## Remaining Tasks
Tasks requiring processing:
- T14: pi.json
- T15: shell.toml
- T16: swayosd.css
- T17: vencord.theme.css
- T18: vscode.json
- T19: vscode-theme.json
- T20: walker.css
- T21: waybar.css

## Verification Fix Applied
The verification commands in tasks.json have been corrected from:
```
grep -n 'pattern' file || echo 'No old colors found'; if [ $? -eq 0 ]; then echo 'Old colors found...'
```
to:
```
if grep -q 'pattern' file; then echo 'Old colors found...'; else echo 'Old colors not found...'; fi
```

## Execution Plan
Since the file updates have largely been completed by background agents, and the verification logic is now fixed, I will:
1. Mark completed tasks as complete in tasks.json
2. Process remaining tasks using the loop engineering approach
3. Verify all theme conversions are correct

## Color Mapping Reference
For all files, replace:
- #2a2a26 → #000000 (background)
- #fbc6c8 → #BAC8B1 (foreground)
- #bf3533 → #8FA4AB (accent)
- #8bc7c3 → varies by position in palette
- #e98129 → varies by position in palette

ANSI 16-color palette mapping:
- color0/color8: #000000
- color1/color9: #000000
- color2/color10: #4D5F64
- color3/color11: #4D5F64
- color4/color12: #6F9C97
- color5/color13: #6F9C97
- color6/color14: #8FA4AB
- color7/color15: #BAC8B1