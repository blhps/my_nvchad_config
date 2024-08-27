require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

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

map("n", "<leader>ln", "<cmd> cnext <CR>", { desc ="Next item in the quick fix list" })
map("n", "<leader>lp", "<cmd> cprevious <CR>", { desc ="Previous item in the quick fix list" })
map("n", "<leader>lc", "<cmd> cclose <CR>", { desc ="Close the quick fix list" })

map("n", "<leader>gg", "<cmd> Neogit <CR>", { desc ="Open Neogit" })

map("n", "<F2>", "@a",  { desc ="Run the macro in register a" })

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
