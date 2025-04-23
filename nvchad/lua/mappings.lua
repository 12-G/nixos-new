require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>m", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
map("n", "J", "mzJ`z", { desc = "press J and won't change your cursor location" })
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv", { desc = "make your cursor in the middle screen when search" })
map("n", "N", "Nzzzv", { desc = "make your cursor in the middle screen when search" })
map("n", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("n", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Telescope
map("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files() <CR>")
map("n", "<leader>fg", "<cmd> Telescope live_grep <CR>")
map("n", "<leader>fb", "<cmd> Telescope buffers <CR>")
map("n", "<leader>fo", "<cmd> Telescope oldfiles <CR>")
map("n", "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>")
