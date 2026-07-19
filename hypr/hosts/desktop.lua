-- Desktop dual-monitor layout.
--
-- Keep machine-specific monitor output names here so the shared Hyprland
-- config can be used safely on laptops and other machines.

hl.monitor({
    output = "DP-3",
    mode = "1920x1080@60",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@100",
    position = "1920x0",
    scale = 1,
})

hl.workspace_rule({
    workspace = "1",
    monitor = "DP-3",
    default = true,
    persistent = true,
})

hl.workspace_rule({
    workspace = "10",
    monitor = "HDMI-A-1",
})
