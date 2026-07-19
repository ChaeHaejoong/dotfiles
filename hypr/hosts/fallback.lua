-- Safe fallback for unknown machines.
--
-- Hyprland picks the available monitor automatically. This file is loaded
-- when hypr/local.lua does not exist.

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})
