-- Laptop layout.
--
-- eDP-1 is the built-in laptop panel. This avoids applying desktop-only
-- DP-3 / HDMI-A-1 rules on the laptop.

hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "0x0",
	scale = "auto",
})

hl.workspace_rule({
	workspace = "1",
	monitor = "eDP-1",
	default = true,
	persistent = true,
})
