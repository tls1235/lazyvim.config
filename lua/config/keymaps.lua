local builtin = require("telescope.builtin")
-- local mark = require("harpoon.mark")
-- local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fs", function()
  builtin.grep_string({ search = vim.fn.input("grep > ") })
end)
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Telescope .git" })

-- this is for harpoon
-- vim.keymap.set("n", "<leader>a", mark.add_file)
-- vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

-- bufferline: jump to buffer by position in the tabline (replaces harpoon nav_file binds)
local buffer_keys = { "1", "2", "3", "q", "w", "e", "a", "s", "d" }
for i, key in ipairs(buffer_keys) do
  vim.keymap.set("n", "<A-" .. key .. ">", function()
    require("bufferline").go_to(i, true)
  end, { desc = "Go to buffer " .. i })
end

-- bufferline: move current buffer left/right in the tabline
vim.keymap.set("n", "<A-x>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer left" })
vim.keymap.set("n", "<A-c>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer right" })
vim.keymap.set("n", "<A-z>", function()
  Snacks.bufdelete()
end, { desc = "Delete current buffer" })
