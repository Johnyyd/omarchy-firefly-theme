#!/usr/bin/env bash
set -Eeuo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
theme_name=firefly
theme_dir="$HOME/.config/omarchy/themes/$theme_name"
template_dir="$HOME/.config/omarchy/themed"
template_path="$template_dir/kitty.conf.tpl"
state_dir="$HOME/.local/state/omarchy-firefly-theme"
backup_dir="$state_dir/backups/$(date +%Y%m%d-%H%M%S)-$$"
current_theme_file="$HOME/.local/state/omarchy/current/theme.name"
current_background_link="$HOME/.local/state/omarchy/current/background"
runtime_theme_dir="$HOME/.local/state/omarchy/current/theme"
vscode_settings=(
  "$HOME/.config/Code/User/settings.json"
  "$HOME/.config/Code - Insiders/User/settings.json"
  "$HOME/.config/VSCodium/User/settings.json"
  "$HOME/.config/Cursor/User/settings.json"
)

command -v omarchy >/dev/null || { echo "omarchy is required" >&2; exit 1; }

mkdir -p "$backup_dir" "$(dirname -- "$theme_dir")"

previous_theme=""
if [[ -f $current_theme_file ]]; then
  previous_theme=$(<"$current_theme_file")
fi
printf '%s\n' "$previous_theme" > "$backup_dir/previous-theme"

previous_background=$(readlink -f "$current_background_link" 2>/dev/null || true)
printf '%s\n' "$previous_background" > "$backup_dir/previous-background"

if [[ -d $runtime_theme_dir ]]; then
  cp -a "$runtime_theme_dir" "$backup_dir/runtime-theme"
fi

for settings_path in "${vscode_settings[@]}"; do
  if [[ -f $settings_path ]]; then
    settings_name=$(printf '%s' "$settings_path" | sha256sum | cut -d' ' -f1)
    cp -- "$settings_path" "$backup_dir/vscode-settings-$settings_name.json"
    printf '%s\n' "$settings_path" >> "$backup_dir/vscode-settings.manifest"
  fi
done

if [[ -e $theme_dir || -L $theme_dir ]]; then
  mv -- "$theme_dir" "$backup_dir/theme"
fi

template_files=(kitty.conf.tpl alacritty.toml.tpl ghostty.conf.tpl foot.ini.tpl)

for tpl in "${template_files[@]}"; do
  tpl_path="$template_dir/$tpl"
  if [[ -e $tpl_path || -L $tpl_path ]]; then
    mv -- "$tpl_path" "$backup_dir/$tpl"
  fi
done

mkdir -p "$theme_dir" "$template_dir"
cp -a "$repo_dir/." "$theme_dir/"

for tpl in "${template_files[@]}"; do
  if [[ -f "$repo_dir/$tpl" ]]; then
    cp -- "$repo_dir/$tpl" "$template_dir/$tpl"
  fi
done

# Ensure .git exists in the theme dir so Omarchy treats it as a repo-installed theme,
# keeping runtime configurations identical to `omarchy-theme-install`.
if [[ ! -d "$theme_dir/.git" ]]; then
  git -C "$theme_dir" init -q 2>/dev/null || true
fi

find "$repo_dir" -maxdepth 1 -type f -printf '%f\n' | sort > "$backup_dir/installed-files"

printf '%s\n' "$backup_dir" > "$state_dir/latest-backup"

omarchy theme set "$theme_name"

# Apply Firefly Hyprland configuration (with transparent window rules)
cp -- "$repo_dir/hyprland.lua" "$runtime_theme_dir/hyprland.lua"
omarchy-restart-hyprctl 2>/dev/null || true

# Sync VS Code theme extension and settings with the new theme colors
cp -- "$repo_dir/vscode-theme.json" "$runtime_theme_dir/vscode-theme.json"
omarchy-theme-set-vscode 2>/dev/null || true

# Sync transparent terminal and monitor configs to runtime
for conf in kitty.conf alacritty.toml ghostty.conf foot.ini btop.theme; do
  if [[ -f "$repo_dir/$conf" ]]; then
    cp -- "$repo_dir/$conf" "$runtime_theme_dir/$conf"
  fi
done
omarchy-restart-terminal 2>/dev/null || true

echo "Firefly theme installed and applied."
echo "Backup: $backup_dir"