return {
	"mfussenegger/nvim-dap",
	lazy = false,
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap-python",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_python = require("dap-python")

		require("dapui").setup({})
		require("nvim-dap-virtual-text").setup({
			commented = true, -- Show virtual text alongside comment
		})

		dap_python.setup("python3")

		vim.fn.sign_define("DapBreakpoint", {
			text = "",
			texthl = "DiagnosticSignError",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapBreakpointRejected", {
			text = "", -- or "❌"
			texthl = "DiagnosticSignError",
			linehl = "",
			numhl = "",
		})

		vim.fn.sign_define("DapStopped", {
			text = "", -- or "→"
			texthl = "DiagnosticSignWarn",
			linehl = "Visual",
			numhl = "DiagnosticSignWarn",
		})

		-- Automatically open/close DAP UI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end

		local map = vim.keymap.set

		local nmap = function(keys, func, desc)
			if desc then
				desc = "DAP: " .. desc
			end
			map("n", keys, func, { noremap = true, silent = true, desc = desc })
		end

		-- Toggle breakpoint
		nmap("<leader>Db", function()
			dap.toggle_breakpoint()
		end, "Toogle [D]ebug [b]reakpoint")

		-- Continue / Start
		nmap("<leader>Dc", function()
			dap.continue()
		end, "[D]ebug [c]ontinue")

		-- Step Over
		nmap("<leader>Do", function()
			dap.step_over()
		end, "[D]ebug step [o]ver")

		-- Step Into
		nmap("<leader>Di", function()
			dap.step_into()
		end, "[D]ebug step [i]nto")

		-- Step Out
		nmap("<leader>DO", function()
			dap.step_out()
		end, "[D]ebug [O]ut")

		-- Keymap to terminate debugging
		nmap("<leader>Dq", function()
			require("dap").terminate()
		end, "[D]ebug [q]uit")

		-- Toggle DAP UI
		nmap("<leader>Du", function()
			dapui.toggle()
		end, "[D]ebug [u]i toggle")
	end,
}
