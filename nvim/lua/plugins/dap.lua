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

            require("dap.ext.vscode").load_launchjs()

            dap.adapters.codelldb = {
                type = 'server',
                port = "${port}",
                executable = {
                    command = '/.vscode-oss/extensions/vadimcn.vscode-lldb-1.9.2-universal/adapter/codelldb',
                    args = { "--port", "${port}" },
                }
            }

            -- dap.configurations.rust = {
            --     {
            --         name = "Rust debug",
            --         type = "codelldb",
            --         request = "launch",
            --         showDisassembly = "never",
            --         program = function()
            --             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
            --         end,
            --         cwd = '${workspaceFolder}',
            --         stopOnEntry = true,
            --     },
            -- }
        end
    },
    { "theHamsta/nvim-dap-virtual-text" }
}
