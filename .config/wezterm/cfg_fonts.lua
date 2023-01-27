local wezterm = require("wezterm")

local cfg = {}

cfg.font_size = 14
cfg.freetype_load_target = "Normal"

cfg.font = wezterm.font_with_fallback({ "JetBrains Mono", "nonicons", "PowerlineExtraSymbols", "Noto Color Emoji" })

-- FIXME (<- this is an example of bolded text)
-- 0 1 2 3 4 5 6 7 8 9
-- Some ligatures: != <-> <-  -> ----> => ==> ===> -- --- /../;;/ #{}
--  <> <!-- --> ->> --> <= >= ++ == === := a::b::c a&&b a||b
cfg.harfbuzz_features = {
	"kern", -- (default) kerning (todo check what is really is)
	"liga", -- (default) ligatures
	"clig", -- (default) contextual ligatures
}

return cfg
