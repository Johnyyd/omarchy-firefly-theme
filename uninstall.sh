#!/usr/bin/env bash
set -Eeuo pipefail

theme_name=firefly
theme_dir="$HOME/.config/omarchy/themes/$theme_name"
template_path="$HOME/.config/omarchy/themed/kitty.conf.tpl"
state_dir="$HOME/.local/state/omarchy-firefly-theme"
latest_file="$state_dir/latest-backup"
current_theme_file="$HOME/.local/state/omarchy/current/theme.name"
runtime_theme_dir="$HOME/.local/state/omarchy/current/theme"
vscode_settings=(
  "$HOME/.config/Code/User/settings.json"
  "$HOME/.config/Code - Insiders/User/settings.json"
  "$HOME/.config/VSCodium/User/settings.json"
  "$HOME/.config/Cursor/User/settings.json"
)

command -v omarchy >/dev/null || { echo "omarchy is required" >&2; exit 1; }

if [[ ${1:-} != "--yes" ]]; then
  read -r -p "Restore the configuration saved before Firefly install? [y/N] " answer
  [[ $answer == [yY] ]] || { echo "Cancelled."; exit 0; }
fi

[[ -s $latest_file ]] || { echo "No Firefly installation backup found." >&2; exit 1; }
backup_dir=$(<"$latest_file")
[[ -d $backup_dir ]] || { echo "Backup is missing: $backup_dir" >&2; exit 1; }

rm -rf -- "$theme_dir"
if [[ -e $backup_dir/theme || -L $backup_dir/theme ]]; then
  mkdir -p "$(dirname -- "$theme_dir")"
  mv -- "$backup_dir/theme" "$theme_dir"
fi

template_files=(kitty.conf.tpl alacritty.toml.tpl ghostty.conf.tpl foot.ini.tpl)
for tpl in "${template_files[@]}"; do
  tpl_path="$HOME/.config/omarchy/themed/$tpl"
  rm -f -- "$tpl_path"
  if [[ -e $backup_dir/$tpl || -L $backup_dir/$tpl ]]; then
    mkdir -p "$(dirname -- "$tpl_path")"
    mv -- "$backup_dir/$tpl" "$tpl_path"
  fi
done

previous_theme=$(<"$backup_dir/previous-theme")
if [[ -n $previous_theme ]]; then
  omarchy theme set "$previous_theme"
else
  rm -rf -- "$runtime_theme_dir"
  if [[ -d $backup_dir/runtime-theme ]]; then
    mkdir -p "$(dirname -- "$runtime_theme_dir")"
    cp -a "$backup_dir/runtime-theme" "$runtime_theme_dir"
  fi
  rm -f -- "$current_theme_file"
fi

if [[ -f $backup_dir/vscode-settings.manifest ]]; then
  while IFS= read -r settings_path; do
    [[ -n $settings_path ]] || continue
    settings_name=$(printf '%s' "$settings_path" | sha256sum | cut -d' ' -f1)
    if [[ -f $backup_dir/vscode-settings-$settings_name.json ]]; then
      mkdir -p "$(dirname -- "$settings_path")"
      cp -- "$backup_dir/vscode-settings-$settings_name.json" "$settings_path"
    fi
  done < "$backup_dir/vscode-settings.manifest"
fi

previous_background=$(<"$backup_dir/previous-background")
if [[ -f $previous_background ]]; then
  omarchy theme bg set "$previous_background"
fi

rm -f -- "$latest_file"
echo "Firefly theme removed and the previous configuration restored."