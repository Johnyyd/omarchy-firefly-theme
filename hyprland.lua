local active_border_color = { colors = { "rgba(BAC8B1ff)", "rgba(BAC8B1cc)", "rgba(BAC8B1aa)" }, angle = 35 }
local inactive_border_color = "rgba(6F9C9799)"

hl.config({
  general = {
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
  },
})

-- Transparent background (opacity 80% active, 75% inactive) for GUI apps & IDEs
local transparent_apps = {
  "code", "Code", "code-url-handler", "cursor", "VSCodium", "codium",
  "antigravity-ide", "antigravity-ide-url-handler",
  "GitHub Desktop", "github-desktop",
  "obsidian", "Obsidian",
  "dev.zed.Zed", "zed", "Zed", "sublime_text",
  "discord", "vesktop", "WebCord",
  "org.telegram.desktop", "telegram-desktop",
  "Slack", "slack", "WhatsApp",
  "org.gnome.Nautilus", "nautilus",
  "spotify", "Spotify",
}

for _, app in ipairs(transparent_apps) do
  o.window("^" .. app .. "$", { tag = "-default-opacity", opacity = "0.80 0.75" })
  o.window({ class = "^" .. app .. "$" }, { tag = "-default-opacity", opacity = "0.80 0.75" })
end
