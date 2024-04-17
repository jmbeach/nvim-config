local get_harpoon_function = function(index)
  return function()
    require("harpoon"):list("my_marks"):select(index)
  end
end
local select_harpoon_in_telescope = function()
  local index = require("telescope.actions.state").get_selected_entry().index
  require("harpoon"):list("my_marks"):select(index)
end

local harpoon_it = function()
  local my_marks = require("harpoon"):list("my_marks")

  local row = vim.fn.line(".")
  local col = vim.fn.col(".")
  local file = vim.fn.expand("%:.")
  local result = {
    value = {
      file = file,
      line = row,
      column = col,
    },
  }
  my_marks:add(result)
  vim.notify("󰆤 File Harpooned 󰆤", vim.log.levels.INFO, { title = "Harpoon", icon = "󰯇" })
end

local remove_harpoon = function()
  local selection = require("telescope.actions.state").get_selected_entry()
  require("harpoon"):list("my_marks"):remove_at(selection.index)
  require("telescope.actions").close(vim.api.nvim_get_current_buf())
end

local function prepare_results(list)
  local next = {}
  for idx = 1, #list do
    list[idx].index = idx
    table.insert(next, list[idx])
  end

  return next
end

local generate_new_finder = function()
  local harpoon = require("harpoon")
  local finders = require("telescope.finders")
  return finders.new_table({
    results = prepare_results(harpoon:list("my_marks").items),
    entry_maker = function(entry)
      local line = entry.value.file .. ":" .. entry.value.line .. ":" .. entry.value.column
      local displayer = require("telescope.pickers.entry_display").create({
        separator = " - ",
        items = {
          { width = 2 },
          { width = 50 },
          { remaining = true },
        },
      })
      local make_display = function()
        return displayer({
          tostring(entry.index),
          line,
        })
      end
      local result = {
        value = line,
        ordinal = line,
        display = make_display,
        lnum = entry.value.line,
        col = entry.value.column,
        filename = entry.value.file,
      }
      return result
    end,
  })
end

local toggle_harpoon = function()
  local conf = require("telescope.config").values

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = generate_new_finder(),
      previewer = conf.grep_previewer({}),
      sorter = conf.generic_sorter({}),
      attach_mappings = function(_, map)
        map("n", "<c-d>", remove_harpoon)
        map("i", "<c-d>", remove_harpoon)
        map("n", "<c-y>", select_harpoon_in_telescope)
        map("i", "<c-y>", select_harpoon_in_telescope)
        return true
      end,
    })
    :find()
end
-- harpoon keybindings

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon"):setup({
      my_marks = {
        select = function(entry)
          local existing = vim.fn.bufwinnr(entry.value.file)
          if existing ~= -1 then
            vim.cmd(existing .. "wincmd w")
          else
            vim.cmd("e " .. entry.value.file)
          end
          vim.fn.cursor({ entry.value.line, entry.value.column })
        end,
      },
    })
  end,
  keys = {
    { "<leader>1", get_harpoon_function(1), { desc = "Open harpoon window 1" } },
    { "<leader>2", get_harpoon_function(2), { desc = "Open harpoon window 2" } },
    { "<leader>3", get_harpoon_function(3), { desc = "Open harpoon window 3" } },
    { "<leader>4", get_harpoon_function(4), { desc = "Open harpoon window 4" } },
    { "<leader>5", get_harpoon_function(5), { desc = "Open harpoon window 5" } },
    { "<leader>H", harpoon_it, { desc = "Harpoon File" } },
    { "<leader>h", toggle_harpoon, { desc = "Open harpoon window" } },
  },
}
