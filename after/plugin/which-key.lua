local wk = require("which-key")

wk.add({
    { "<leader>f", group = "find" },
    { "<leader>g", group = "git" },
    { "<leader>u", group = "ui" },
    { "<leader>x", group = "diagnostics" },
    { "g", group = "goto" },
})

local defaults = {
    preset = "modern"
}

wk.setup(defaults)
