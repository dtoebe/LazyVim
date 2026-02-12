return {
	-- treesitter already handles html attributes; no special parser needed
	-- add snippets for htmx
	{
		"L3MON4D3/LuaSnip",
		opts = function(_, opts)
			local ls = require("luasnip")
			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node

			ls.add_snippets("html", {
				s("hxget", {
					t('<div hx-get="'),
					i(1, "/path"),
					t('" hx-target="'),
					i(2, "#id"),
					t('" hx-swap="'),
					i(3, "innerHTML"),
					t('">'),
					i(4, "Link text"),
					t("</div>"),
				}),
			})
			return opts
		end,
	},
}
