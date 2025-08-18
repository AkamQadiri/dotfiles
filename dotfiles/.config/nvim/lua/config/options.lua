-- === APPEARANCE & UI ===
vim.opt.guicursor = ""
vim.opt.showmode = false
vim.opt.cmdheight = 0
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- === LINE NUMBERS & NAVIGATION ===
vim.opt.nu = true
vim.opt.relativenumber = true

-- === TABS & INDENTATION ===
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- === FILE HANDLING & UNDO ===
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undodir"
vim.opt.undofile = true

-- === SEARCH ===
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- === PERFORMANCE ===
vim.opt.updatetime = 50
