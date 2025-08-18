--[[
========================= KEYMAP SYSTEM =========================

This configuration follows a semantic keymap system that respects Vim's 
defaults while organizing custom functionality into logical groups.

CORE PRINCIPLES:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. Preserve Vim defaults where they make sense (gd, gr, K, gcc, etc.)
2. Use <leader> only for custom functionality without natural defaults
3. Group related actions semantically, not by plugin name
4. Use two-letter mnemonics for clarity (gps = git push, gpl = git pull)
5. Write descriptions that explain the ACTION, not the tool

KEYMAP CATEGORIES:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
┌─────────────┬──────────────────────────────────────────────────────┐
│ Prefix      │ Category & Purpose                                   │
├─────────────┼──────────────────────────────────────────────────────┤
│ (default)   │ Vim motions: gd, gr, gi, K, gcc, gb, etc.            │
│ F1-F12      │ DEBUG: F5 run, F9 breakpoint, F10/F11 step           │
│ <leader>f   │ FIND: files, grep, search, todos, symbols, help      │
│ <leader>c   │ CODE: refactor, rename, actions, format, clipboard   │
│ <leader>d   │ DIAGNOSTICS: errors, warnings, trouble, todos        │
│ <leader>g   │ GIT: status, commit, push, pull, blame, diff         │
│ <leader>l   │ LOCATION LIST: navigation and list management        │
│ <leader>q   │ QUICKFIX: navigation and list management             │
│ <leader>u   │ UI/TOOLS: themes, pickers, toggles, utilities        │
│ <leader>m   │ MARKS: harpoon, bookmarks, navigation marks          │
└─────────────┴──────────────────────────────────────────────────────┘

DESCRIPTION GUIDELINES:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
- State what HAPPENS: "Open git status window" not "Git status"
- Include WHERE: "Show diagnostic in float" not just "Show diagnostic"  
- Specify SCOPE: "Format current buffer" not just "Format"
- Use VERBS: "Jump to", "Open", "Show", "Toggle", "Create", "Search"

COMMON PATTERNS:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
- Single letter for frequent actions: <leader>ff (find files)
- Two letters for clarity: <leader>gps (git push), <leader>gpl (git pull)
- Uppercase for variants: <leader>fw (word), <leader>fW (WORD)
- Shift for opposites: F5 (start), Shift-F5 (stop)
- 'j' and 'k' for next/previous: <leader>dj, <leader>dk (like j/k movement)
  (Norwegian keyboard friendly - avoids brackets [])

When adding new keymaps, ask: "What am I trying to DO?" not "What 
plugin am I using?" Place the keymap in the appropriate semantic category.
=========================================================================
--]]

vim.g.mapleader = " "

-- === BUILT-IN VIM MOTIONS (Keep defaults) ===
-- Line movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus window left" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus window down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus window up" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus window right" })

-- Navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half page down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half page up" })

-- === FIND/SEARCH (<leader>f*) ===
vim.keymap.set("n", "<leader>fe", vim.cmd.Ex, { desc = "Open file explorer" })

-- === CODE ACTIONS (<leader>c*) ===
vim.keymap.set({ "n", "v" }, "<leader>cy", [["+y]], { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>cY", [["+Y]], { desc = "Copy line to system clipboard" })
vim.keymap.set(
	"n",
	"<leader>cs",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace cursor word in file" }
)

-- === DIAGNOSTICS (<leader>d*) ===
vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "Jump to next diagnostic" })
vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "Jump to previous diagnostic" })
vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show diagnostic details in float" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Add buffer diagnostics to location list" })

-- === LOCATION LIST (<leader>l*) ===
vim.keymap.set("n", "<leader>lj", "<cmd>lnext<CR>zz", { desc = "Jump to next location list item" })
vim.keymap.set("n", "<leader>lk", "<cmd>lprev<CR>zz", { desc = "Jump to previous location list item" })
vim.keymap.set("n", "<leader>ll", "<cmd>lopen<CR>", { desc = "Open location list" })
vim.keymap.set("n", "<leader>lc", "<cmd>lclose<CR>", { desc = "Close location list" })

-- === QUICKFIX (<leader>q*) ===
vim.keymap.set("n", "<leader>qj", "<cmd>cnext<CR>zz", { desc = "Jump to next quickfix item" })
vim.keymap.set("n", "<leader>qk", "<cmd>cprev<CR>zz", { desc = "Jump to previous quickfix item" })
vim.keymap.set("n", "<leader>ql", "<cmd>copen<CR>", { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>qc", "<cmd>cclose<CR>", { desc = "Close quickfix list" })

-- === UI/TOOLS (<leader>u*) ===
vim.keymap.set("n", "<leader>ux", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file executable" })

