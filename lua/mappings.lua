require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- AÖ added ============================================================
-- Disable some defaults:
local nomap = vim.keymap.del
nomap( "n", "<leader>v")
nomap( "n", "<leader>h")

map( { "i", "n" }, "<C-a>", "<esc> <cmd> ClangdSwitchSourceHeader <CR>", { desc = "Switch betwwen header and source" })
map("i", "<C-s>", "<esc> <cmd> w <CR> gi", { desc = "Save buffer" })
map("i", "<A-j>", "<esc> <C-e> gi", { desc = "Scroll down" })
map("i", "<A-k>", "<esc> <C-y> gi", { desc = "Scroll up" })
map("i", "<A-J>", "<esc> <cmd> m .+1 <CR> gi", { desc = "Move active line down" })
map("i", "<A-K>", "<esc> <cmd> m .-2 <CR> gi", { desc = "Move active line up" })
map("i", "<A-;>", "<esc> $a;",  { desc = "Add ; to end" })

map("n", "<A-j>", "jzz", { desc = "Scroll down" })
map("n", "<A-k>", "kzz", { desc = "Scroll up" })
map("n", "<A-J>", "<cmd> m .+1 <CR>", { desc = "Scroll down" })
map("n", "<A-K>", "<cmd> m .-2 <CR>", { desc = "Scroll up" })
map("n", "<leader><leader>", "i <esc>l", { desc = "Add space at cursor" })
map("n", "<leader>;", "$a;<esc>", { desc = "Add ; to end" })

map("n","<leader>rts", "<cmd>%s/\\s\\+$//e<CR>", { desc = "Remove trailing whitespaces" })

map("n","<leader>s",
      function()
        local curr_line = vim.api.nvim_get_current_line()
        local row = vim.api.nvim_win_get_cursor(0)[1]
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local space_count = curr_line:sub( col + 1 ):reverse():find( "%S" )

        if space_count == nil then
          space_count = 0;
        end

        local curr_line_new = curr_line:sub(0, col + 1 - space_count)
        local spaces = string.rep( ' ', curr_line:find( "%S") )

        vim.api.nvim_set_current_line(curr_line_new)
        vim.api.nvim_buff_set_lines( 0, row, row, false, { spaces .. curr_line:sub( col + 1 ) } )
        vim.api.nvim_win_set_cursor( 0, { row + 1, #spaces } )
        -- TO BE FIXED
        return ""
      end,
    { desc ="Split line at cursor" })

map("n", "<leader>tn", "<cmd> tabn <CR>", { desc ="Next tab" })
map("n", "<leader>tp", "<cmd> tabp <CR>", { desc ="Previous tab" })
map("n", "<leader>tc", "<cmd> tabc <CR>", { desc ="Close tab" })

map("n", "<leader>lo", "<cmd> copen <CR>", { desc ="Open the quick fix list" })
map("n", "<leader>lc", "<cmd> cclose <CR>", { desc ="Close the quick fix list" })
map("n", "<leader>ln", "<cmd> cnext <CR>", { desc ="Next item in the quick fix list" })
map("n", "<leader>lp", "<cmd> cprevious <CR>", { desc ="Previous item in the quick fix list" })

map("n", "<F2>", "@a",  { desc ="Run the macro in register a" })

map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm", size=0.4 }
end, { desc = "terminal toggleable vertical term" })

map("n", "<leader><lt>",
      function()
        local curr_line = vim.api.nvim_get_current_line()
        local prev_line = vim.fn.getline(vim.fn.line('.') - 1)
        local row = vim.api.nvim_win_get_cursor(0)[1]
        local col = vim.api.nvim_win_get_cursor(0)[2]
        -- local spaces = vim.fn.matchstr(prev_line:sub(col), '\\s*')
        local size = string.find( prev_line:sub( col + 1 ), '%s' )

        if size == 1 then
          -- vim.print( "size=1" .. " col=" .. col .. " -" .. prev_line:sub( col + 1 ) )
          size = string.find( prev_line:sub( col + 1 ), '%S') - 1
        elseif size == nil then
          vim.print( "size=nil " .. prev_line:sub( col + 1 ) )
          return ""
        else
          -- vim.print( "size= " .. size .. " - " .. prev_line:sub( col + 1 ) )
          local size2 = string.find( prev_line:sub( col + size ), '%S')
          if size2 == nil then
            vim.print( "size=nil " .. prev_line:sub( col + size ) )
            return ""
          else
            size = size + size2 - 2
          end
        end

        local spaces = string.rep( ' ', size )
        local new_line = curr_line:sub(0, col) .. spaces .. curr_line:sub(col + 1)

        vim.api.nvim_set_current_line(new_line)
        vim.api.nvim_win_set_cursor( 0, { row, #spaces + col } )
        -- return #spaces > 0 and spaces or '<Tab>'
        return ""
      end,
      { desc ="Align cursor to the first non-space char above"})

-- DAP
map("n", "<F5>", "<cmd> DapContinue <CR>", { desc = "DAP: Start or continue the debugger", })
map("n", "<F6>", "<cmd> DapStepOver <CR>", { desc = "DAP: Step over the expression", })
map("n", "<F7>", "<cmd> DapStepInto <CR>", { desc = "DAP: Step into the expression", })
map("n", "<F8>", "<cmd> DapStepOut <CR>", { desc = "DAP: Step out of the expression", })
map("n", "<F9>", "<cmd> DapTerminate <CR>", { desc = "DAP: Terminate debugging", })
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "DAP: Add breakpoint at line", })
map("n", "<leader>dut", ":lua require('dapui').toggle() <CR>", { desc = "DAP: Toggle Dap-UI", })
map("n", "<leader>i",
      function()
        require("dapui").eval()
      end,
      -- ":lua require('dap.ui.variables').hover() <CR>",
      { desc = "Inspect the variable at cursor"})
map("n", "<leader>dsu", ":lua require('dap').up() <CR>", { desc = "DAP: Go up in debug stack", })
map("n", "<leader>dsd", ":lua require('dap').down() <CR>", { desc = "DAP: Go down in debug stack", })

-- LSP
map("n", "<leader>gE",
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      { desc = "LSP: Goto prev", })
map("n", "<leader>ge",
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      { desc = "LSP: Goto next", })

-- GITSIGNS
-- Navigation through hunks
map("n", "<leader>gh",
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      { desc = "GITSIGNS: Jump to next hunk",
        -- opts = { expr = true },
      })
map("n", "<leader>gH",
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      { desc = "GITSIGNS: Jump to prev hunk",
        -- opts = { expr = true },
    })
-- Actions
map("n", "<leader>rh", function() require("gitsigns").reset_hunk() end, { desc = "GITSIGNS: Reset hunk", })

map("n", "<cmd>reset_buf <CR>", function() require("gitsigns").reset_buffer() end, { desc = "GITSIGNS: Reset buffer", })

map("n", "<leader>ph", function() require("gitsigns").preview_hunk() end, { desc = "GITSIGNS: Preview hunk", })

map("n", "<leader>gs", function() require("gitsigns").stage_hunk() end, { desc = "GITSIGNS: Stage hunk", })

map("n", "<leader>gS", function() package.loaded.gitsigns.undo_stage_hunk() end, { desc = "GITSIGNS: Unstage hunk", })

-- map("n", "<leader>gb", function() package.loaded.gitsigns.blame_line() end, { desc = "Blame line", })

    -- ["<leader>gdt", function() package.loaded.gitsigns.diffthis() end, { desc = "Diffthis", })
map("n", "<leader>dv", "<cmd> DiffviewOpen <CR>", { desc = "GITSIGNS: Open Diffview", })
map("n", "<leader>dx", "<cmd> DiffviewClose <CR>", { desc = "GITSIGNS: Close Diffview", })

map("n", "<leader>td", function() require("gitsigns").toggle_deleted() end, { desc = "GITSIGNS: Toggle deleted", })

map("n", "<cmd> stage_buf <CR>", function() require("gitsigns").stage_buffer() end, { desc = "GITSIGNS: Stage buffer", })

-- TELESCOPE
map("n", "<leader>fd", "<cmd> Telescope diagnostics <CR>", { desc = "TELESCOPE: Find LSP output" })
map("n", "<leader>frb", "<cmd> Telescope lsp_document_symbols symbol_width=50 <CR>", { desc = "TELESCOPE: Lists LSP document symbols in the current buffer" })
map("n", "<leader>frw", "<cmd> Telescope lsp_workspace_symbols symbol_width=50 <CR>", { desc = "TELESCOPE: Lists LSP document symbols in the current workspace" })
map("n", "<leader>gr", "<cmd> Telescope lsp_references <CR>", { desc = "TELESCOPE: Lists LSP references for word under the cursor" })
map("n", "<leader>gc", "<cmd> Telescope grep_string <CR>", { desc = "TELESCOPE: Find occurrences of the word at the cursor" })
map("n", "<leader>km", "<cmd> Telescope keymaps <CR>", { desc = "TELESCOPE: Find keymaps" })
map("v", "<leader>fw", "\"zy<cmd>exec 'Telescope grep_string default_text=' . escape(@z, ' ')<CR>", { desc = "TELESCOPE: Live Grep the selected text" })
map("n", "<leader>j", "<cmd> Telescope jumplist <CR>", { desc = "TELESCOPE: jumplist" })
