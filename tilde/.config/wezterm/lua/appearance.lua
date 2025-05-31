local wezterm = require("wezterm")

local M = {}

M.color_scheme = "GruvboxDarkHard"
M.font = wezterm.font_with_fallback({
	"JetBrainsMono Nerd Font",
	"Iosevka Nerd Font",
	"Arial",
})
M.font_size = 16
M.enable_tab_bar = false

return M
