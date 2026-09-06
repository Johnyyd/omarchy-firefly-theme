return {
	{
		"bjarneo/aether.nvim",
		branch = "v2",
		name = "aether",
		priority = 1000,
		opts = {
			transparent = false,
			colors = {
				-- Background colors
				bg = "#000000",
				bg_dark = "#000000",
				bg_highlight = "#4D5F64",

				-- Foreground colors
				-- fg: Object properties, builtin types, builtin variables, member access, default text
				fg = "#BAC8B1",
				-- fg_dark: Inactive elements, statusline, secondary text
				fg_dark = "#6F9C97",
				-- comment: Line highlight, gutter elements, disabled states
				comment = "#6F9C97",

				-- Accent colors
				-- red: Errors, diagnostics, tags, deletions, breakpoints
				red = "#D94F4F",
				-- orange: Constants, numbers, current line number, git modifications
				orange = "#FF7A3D",
				-- yellow: Types, classes, constructors, warnings, numbers, booleans
				yellow = "#FFB347",
				-- green: Comments, strings, success states, git additions
				green = "#6F9C97",
				-- cyan: Parameters, regex, preprocessor, hints, properties
				cyan = "#E85D2A",
				-- blue: Functions, keywords, directories, links, info diagnostics
				blue = "#739099",
				-- purple: Storage keywords, special keywords, identifiers, namespaces
				purple = "#FF7A3D",
				-- magenta: Function declarations, exception handling, tags
				magenta = "#FFB347",
			},
			on_highlights = function(hl, c)
				hl["@constant.builtin"] = { fg = c.orange }
				hl["@keyword.function"] = { fg = c.magenta, bold = true }
				hl["@module"] = { fg = c.purple }
				hl["@property"] = { fg = c.fg_dark }
				hl["@type.builtin"] = { fg = c.blue }
				hl["@variable.member"] = { fg = c.fg_dark }

				-- Force window separators away from the default near-black fallback.
				hl.WinSeparator = { fg = c.comment }
				hl.VertSplit = { fg = c.comment }
				hl.NeoTreeWinSeparator = { fg = c.comment }
				hl.NeoTreeVertSplit = { fg = c.comment }
				hl.NvimTreeVertSplit = { fg = c.comment }

				hl["@lsp.type.class"] = { fg = c.yellow }
				hl["@lsp.type.interface"] = { fg = c.yellow }
				hl["@lsp.type.namespace"] = { fg = c.purple }
				hl["@lsp.type.parameter"] = { fg = c.cyan, italic = true }
				hl["@lsp.type.property"] = { fg = c.fg_dark }
				hl["@lsp.type.struct"] = { fg = c.yellow }
				hl["@lsp.type.type"] = { fg = c.yellow }
				hl["@lsp.type.typeParameter"] = { fg = c.blue }
			end,
		},
		config = function(_, opts)
			require("aether").setup(opts)
			vim.cmd.colorscheme("aether")

			-- Enable hot reload
			require("aether.hotreload").setup()
		end,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "aether",
		},
	},
}                           