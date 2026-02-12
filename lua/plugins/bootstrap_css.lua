return {
	{
		"L3MON4D3/LuaSnip",
		opts = function(_, opts)
			local ls = require("luasnip")
			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node

			ls.add_snippets("html", {
				s("bsrow", {
					t('<div class="row">'),
					t({ "", '  <div class="col">' }),
					t({ "", "    " }),
					i(1),
					t({ "", "  </div>", "</div>" }),
				}),
				-- add your own frequently‑used Bootstrap patterns
			})
			return opts
		end,
	},
}
