local get_harpoon_function = function(index)
  return function()
    require("harpoon"):list("my_marks"):select(index)
  end
end
local select_harpoon_in_telescope = function()
  local index = require("telescope.actions.state").get_selected_entry().index
  require("telescope.actions").close(vim.api.nvim_get_current_buf())
  require("harpoon"):list("my_marks"):select(index)
end

local harpoon_it = function()
  local my_marks = require("harpoon"):list("my_marks")

  local row = vim.fn.line(".")
  local col = vim.fn.col(".")
  local file = vim.fn.expand("%:.")
  local full_path = vim.fn.expand("%:p")
  local result = {
    value = {
      file = file,
      line = row,
      column = col,
      full_path = full_path,
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
    if list[idx] == nil then
      break
    end
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

local get_existing_buffer = function(file)
  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    if vim.api.nvim_buf_get_name(buf) == file then
      return buf
    end
  end
  return -1
end

local buf_is_marked = function(buf)
  local my_marks = require("harpoon"):list("my_marks")
  local name = vim.api.nvim_buf_get_name(buf)
  local found = false
  for _, mark in ipairs(my_marks.items) do
    if mark.value.full_path == name then
      found = true
      break
    end
  end
  return found
end
local close_all_except_marked = function()
  local bufs = vim.api.nvim_list_bufs()
  for _, buf in ipairs(bufs) do
    local is_marked = buf_is_marked(buf)
    if not is_marked then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon"):setup({
      my_marks = {
        select = function(entry)
          -- check if the file is already open
          local existing = get_existing_buffer(entry.value.full_path)
          if existing ~= -1 then
            vim.api.nvim_set_current_buf(existing)
          else
            -- open a new buffer at the file
            vim.cmd("e " .. entry.value.full_path)
          end
          vim.fn.cursor({ entry.value.line, entry.value.column })
        end,
      },
    })
  end,
  keys = {
    { "<leader>1", get_harpoon_function(1), desc = "Open harpoon window 1" },
    { "<leader>2", get_harpoon_function(2), desc = "Open harpoon window 2" },
    { "<leader>3", get_harpoon_function(3), desc = "Open harpoon window 3" },
    { "<leader>4", get_harpoon_function(4), desc = "Open harpoon window 4" },
    { "<leader>5", get_harpoon_function(5), desc = "Open harpoon window 5" },
    { "<leader>H", harpoon_it, desc = "Harpoon File" },
    { "<leader>h", toggle_harpoon, desc = "Open harpoon window" },
    { "<leader>bx", close_all_except_marked, desc = "Close all but marked" },
  },
}
