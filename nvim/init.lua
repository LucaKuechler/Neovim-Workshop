require("plugins")
require("keymappings")
require("settings")
require("colorscheme")

-- Plugins Config
require("config.telescope")
require("config.bufferline")
require("config.statusline")
require("config.autocompletion")
require("config.tabnine")
require("config.nvimtree")
require("config.commentary")
require("config.treesitter")
require("config.indent")
require("config.autopair")
require("config.comments")
require("config.project")

-- LSP Config
require("lsp.lsp-config")
require("lsp.lsp-python")
require("lsp.lsp-docker")
require("lsp.lsp-lua")

-- Linter
require("linter.test")

-- Format
require("formatter.test")

-- Git
require("git.gitsigns")
