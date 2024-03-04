return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = "mfussenegger/nvim-dap",
        keys = {
            {
                "<leader>db",
                function()
                    require("dapui").toggle()
                end,
                silent = true,
                desc = "Toggle DAP UI"
            },
        },
        config = function()
            local dapui = require("dapui")

            dapui.setup({})

            local dap = require("dap")
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end


            vim.keymap.set("n", "<leader>bp", vim.cmd.DapToggleBreakpoint)
            vim.keymap.set("n", "<F9>", vim.cmd.DapContinue)
            vim.keymap.set("n", "<F8>", vim.cmd.DapStepOver)
            vim.keymap.set("n", "<F7>", vim.cmd.DapStepInto)
        end
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            -- Change hl group for better visibility
            vim.api.nvim_set_hl(0, 'NvimDapVirtualText',
                { fg = '#FFFFED', bold = true, ctermfg = 198, cterm = { bold = true } })


            require("nvim-dap-virtual-text").setup({
                virt_text_pos = 'inline'
            })
        end
    }
}
