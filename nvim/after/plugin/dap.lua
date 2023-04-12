local dapui = require("dapui")

dapui.setup()
vim.keymap.set("n", "<leader>db", vim.cmd.DapUiToggle)

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
