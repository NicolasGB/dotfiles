return {
  {
    dir = "~/dev/personal/plugins/jj.nvim",
    -- dir = "~/dev/personal/plugins/jj-pr",
    name = "jj.nvim",
    dependencies = {
      "folke/snacks.nvim",
      "sindrets/diffview.nvim",
      "esmuellert/codediff.nvim",
    },
    config = function()
      local jj = require "jj"
      jj.setup {
        cmd = {
          describe = {
            editor = {
              keymaps = {
                close = { "<Esc>", "<C-c>", "q" },
              },
            },
          },
          bookmark = {
            prefix = "ngb/",
          },
          keymaps = {
            log = {
              fetch = "<S-f>",
            },
          },
        },
        -- terminal = {
        --   window = {
        --     type = "floating",
        --   },
        -- },
        editor = {
          auto_insert = true,
        },
        diff = {
          backend = "codediff",
        },
      }

      local cmd = require "jj.cmd"
      vim.keymap.set("n", "<leader>jd", cmd.describe, { desc = "JJ describe" })
      vim.keymap.set("n", "<leader>jl", cmd.log, { desc = "JJ log" })
      vim.keymap.set("n", "<leader>je", cmd.edit, { desc = "JJ edit" })
      vim.keymap.set("n", "<leader>ja", function()
        cmd.log {
          revisions = "all()",
        }
      end, { desc = "JJ log" })
      vim.keymap.set("n", "<leader>jn", function()
        cmd.new { show_log = true }
      end, { desc = "JJ new" })
      vim.keymap.set("n", "<leader>js", cmd.status, { desc = "JJ status" })

      -- Bookmark deletion
      vim.keymap.set("n", "<leader>jbc", cmd.bookmark_create, { desc = "JJ bookmark create" })
      vim.keymap.set("n", "<leader>jbd", cmd.bookmark_delete, { desc = "JJ bookmark delete" })
      vim.keymap.set("n", "<leader>jbm", cmd.bookmark_move, { desc = "JJ bookmark move" })
      vim.keymap.set("n", "<leader>jbt", cmd.bookmark_track, { desc = "JJ bookmark track" })
      vim.keymap.set("n", "<leader>jbf", cmd.bookmark_forget, { desc = "JJ bookmark forget" })

      -- Tags
      vim.keymap.set("n", "<leader>jtd", function()
        require("jj.cmd").tag_delete()
      end, { desc = "JJ tag delete" })

      vim.keymap.set("n", "<leader>jtp", function()
        require("jj.cmd").tag_push()
      end, { desc = "JJ tag push" })

      -- Push and pull
      vim.keymap.set("n", "<leader>jf", function()
        cmd.fetch()
      end, { desc = "JJ pull" })
      vim.keymap.set("n", "<leader>jP", function()
        cmd.push()
      end, { desc = "JJ push" })
      -- Open a pr
      vim.keymap.set("n", "<leader>jpr", function()
        cmd.open_pr { list_bookmarks = true }
      end, { desc = "JJ open PR" })
      -- Fetch a pr
      vim.keymap.set("n", "<leader>jpf", function()
        cmd.fetch_pr {}
      end, { desc = "JJ fetch PR" })

      vim.keymap.set("n", "<leader>gj", function()
        require("jj.picker").status()
      end, { desc = "JJ Picker status" })
      vim.keymap.set("n", "<leader>jgh", function()
        require("jj.picker").file_history()
      end, { desc = "JJ Picker history" })

      -- Diffs
      local diff = require "jj.diff"
      vim.keymap.set("n", "<leader>df", function()
        diff.open_vdiff()
      end, { desc = "JJ diff current buffer" })

      -- Annotations
      local annotation = require "jj.annotate"
      vim.keymap.set("n", "<leader>bl", function()
        annotation.line()
      end, { desc = "JJ blame" })

      -- vim.api.nvim_create_autocmd("FileType", {
      --   pattern = "jjdescription",
      --   callback = function(ev)
      --     vim.schedule(function()
      --       local lines = vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)
      --       local desc = require("jj.utils").extract_description_from_describe(lines)
      --       if not desc or desc == "" then
      --         vim.cmd "startinsert"
      --       end
      --     end)
      --   end,
      -- })
    end,
  },
  {
    "julienvincent/hunk.nvim",
    cmd = { "DiffEditor" },
    config = function()
      require("hunk").setup()
    end,
  },
  {
    "tpope/vim-fugitive",
  },
  {
    "tpope/vim-rhubarb",
  },
}
