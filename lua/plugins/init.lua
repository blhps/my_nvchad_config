return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },

  -- AÖ added: ===========================================================================
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    -- dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup({
          layouts = { {
            elements = { {
                id = "scopes",
                size = 0.20
              }, {
                id = "breakpoints",
                size = 0.20
              }, {
                id = "stacks",
                size = 0.25
              }, {
                id = "watches",
                size = 0.20
              }, {
                id = "repl",
                size = 0.15
              } },
            position = "left",
            size = 40
          }, {
            elements = { {
              --   id = "repl",
              --   size = 0.5
              -- }, {
                id = "console",
                size = 1.0
              } },
            position = "bottom",
            size = 10
          } },
      })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

    end
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},

    },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    config = function()
        require("diffview").setup({
          hooks = {
            diff_buf_read = function(bufnr)
              vim.opt_local.wrap = false
              -- vim.opt_local.syntax = 'off' DOES NOT WORK
            end,
          },
      })
    end
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },
  {
    "igankevich/mesonic",
    event = "VeryLazy",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("treesitter-context").setup({
          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
          max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
          min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
          line_numbers = true,
          multiline_threshold = 20, -- Maximum number of lines to show for a single context
          trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
          mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
          -- Separator between context and content. Should be a single character string, like '-'.
          -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
          separator = nil,
          zindex = 20, -- The Z-index of the context window
          on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        })
    end
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "nvim-neotest/nvim-nio" },
    config = function (_, _)
      -- require("core.utils").load_mappings("dap")

      -- begin test
      local dap = require("dap")
      dap.configurations.cpp =  {
        {
          name = 'Run Debug',
          type = 'codelldb',
          request = 'launch',
          program  ='${workspaceFolder}/build_dbg/lifeograph',
          cwd = '${workspaceFolder}/build_dbg',
          stopOnEntry = false,
          args = {},
          env = { LIFEOGRAPH_CONFIG_FILE = "${workspaceFolder}/../../materials/lifeo.conf.dev" },
          -- env = { { name = "LIFEOGRAPH_CONFIG_FILE", value = "${workspaceFolder}/../../materials/lifeo.conf.dev" },
                          -- { name = "G_ENABLE_DIAGNOSTIC", value = "1" }, },
        },
        {
          name = 'Run Debug --force-welcome',
          type = 'codelldb',
          request = 'launch',
          program  ='${workspaceFolder}/build_dbg/lifeograph',
          cwd = '${workspaceFolder}/build_dbg',
          stopOnEntry = false,
          args = { "--force-welcome" },
          env = { LIFEOGRAPH_CONFIG_FILE = "${workspaceFolder}/../../materials/lifeo.conf.dev" },
        },
        -- {
        --   name = 'Run Debug Opimized' TODO...
        -- },
      }
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        initial_mode = "normal",
        mappings = {
          i = {
            ["<C-h>"] = "which_key",
          },
          n = {
            ["<C-h>"] = "which_key",
            ["<A-j>"] = "preview_scrolling_down",
            ["<A-k>"] = "preview_scrolling_up",
          }
        }
      },
    }
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "codelldb",
        "lemminx",
      }
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "comment",
        "cpp",
        "meson",
      }
    }
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
        require("nvim-dap-virtual-text").setup({
          enabled = true,
          all_references = true, })
      end,
  },
  {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    opts = {
        -- add any options here
    }
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
}
