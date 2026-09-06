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

command -v omarchy >/dev/null || { echo "omarchy is required" >&2; exit 1; }
[[ -f $repo_dir/kitty.conf.tpl ]] || { echo "kitty.conf.tpl is missing" >&2; exit 1; }

mkdir -p "$backup_dir" "$template_dir" "$(dirname -- "$theme_dir")"

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

if [[ -e $theme_dir || -L $theme_dir ]]; then
  mv -- "$theme_dir" "$backup_dir/theme"
fi
if [[ -e $template_path || -L $template_path ]]; then
  mv -- "$template_path" "$backup_dir/kitty.conf.tpl"
fi

mkdir -p "$theme_dir"
cp -a "$repo_dir/." "$theme_dir/"
rm -rf -- "$theme_dir/.git" "$theme_dir/.github"
cp -- "$repo_dir/kitty.conf.tpl" "$template_path"

find "$repo_dir" -maxdepth 1 -type f -printf '%f\n' | sort > "$backup_dir/installed-files"

printf '%s\n' "$backup_dir" > "$state_dir/latest-backup"

omarchy theme set "$theme_name"

echo "Firefly theme installed and applied."
echo "Backup: $backup_dir"