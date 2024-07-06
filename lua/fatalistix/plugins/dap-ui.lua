-- debug adapter protocol - протокол использования дебаггинга + ui
-- https://github.com/rcarriga/nvim-dap-ui
return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_go = require("dap-go")

		dap_go.setup()
		dapui.setup()

		vim.keymap.set("n", "<F9>", dap.continue, { desc = "DAP continue "})
		vim.keymap.set("n", "<F8>", dap.step_over, { desc = "DAP step over" })
		vim.keymap.set("n", "<F7>", dap.step_into, { desc = "DAP step into" })
		vim.keymap.set("n", "<S-F8>", dap.step_out, { desc = "DAP step out" })
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
		vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "DAP toggle REPL" })
        vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP toggle UI" })
		vim.keymap.set("n", "<leader>dt", dap_go.debug_test, { desc = "DAP golang debug test" }) -- ????

		vim.keymap.set("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
		end, { desc = "DAP set breakpoint with condition" })

		vim.keymap.set("n", "<leader>dl", function()
			dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
		end, { desc = "DAP set breakpoint with log msg" })
	end
}
