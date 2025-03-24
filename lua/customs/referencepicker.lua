local M = {}

local function get_references_sync()
	local references = {}
	local is_done = false
	local params = vim.lsp.util.make_position_params()

	-- Send the request to all LSP servers
	vim.lsp.buf_request_all(0, "textDocument/references", params, function(response)
		-- Process responses from all servers
		for client_id, result in pairs(response) do
			_ = client_id
			if result.result then
				for _, ref in ipairs(result.result) do
					table.insert(references, ref)
				end
			end
		end
		is_done = true
	end)

	-- Wait for results with timeout
	local ok = vim.wait(5000, function()
		return is_done
	end, 100)

	if not ok then
		vim.notify("LSP references request timed out", vim.log.levels.WARN)
		return nil
	end

	return references
end

---@type snacks.picker.finder
local function lsp_references_finder(opts)
	_ = opts

	local references = get_references_sync()
	if references == nil then
		return {}
	end

	---@type snacks.picker.finder.Item[]
	local items = {}

	local files = {}
	local dirs = {}

	for _, ref in ipairs(references) do
		local uri = ref.uri or ref.targetUri
		local filename = vim.uri_to_fname(uri)
		local dirname = vim.fs.dirname(filename)
		local line = ref.range.start.line + 1
		local col = ref.range.start.character + 1
		local ref_item = {
			type = "ref",
			filename = filename,
			dirname = dirname,

			file = filename,
			pos = { line, col },
			ref = ref,

			dir_score = 1,
			file_score = 1,
			ref_score = ref.range.start.line,
		}
		table.insert(items, ref_item)

		local file_item = files[filename]
			or {
				type = "file",
				filename = filename,
				dirname = dirname,
				children = {},

				file = filename,

				dir_score = 1,
				file_score = 0,
			}
		ref_item.parent = file_item
		table.insert(file_item.children, ref_item)

		local dir_item = dirs[dirname]
			or {
				type = "dir",
				filename = filename,
				dirname = dirname,
				children = {},

				file = dirname,
				dir = true,
				open = true,

				dir_score = 0,
				file_score = 0,
			}
		file_item.parent = dir_item
		table.insert(dir_item.children, file_item)

		files[filename] = file_item
		dirs[dirname] = dir_item
	end

	for _, f in pairs(files) do
		f.children[#f.children].last = true
		table.insert(items, f)
	end

	for _, d in pairs(dirs) do
		d.children[#d.children].last = true
		table.insert(items, d)
	end

	return items
end

-- This function queries LSP for references at the current cursor position,
-- groups the results by filename, and then opens a snacks.nvim picker in tree mode.
function M.references()
	require("snacks").picker({
		title = "LSP References by File",
		tree = true,
		finder = lsp_references_finder,
		sort = {
			fields = {
				"dirname",
				"dir_score",
				"file",
				"file_score",
				"ref_score",
			},
		},
		matcher = { sort_empty = true },
		format = require("snacks.picker.format").file,
	})
end

return M
