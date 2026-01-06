-- ~/.config/nvim/lua/plugins/disable-omnisharp.lua
-- Explicitly disable LazyVim's default OmniSharp configuration
return {
	-- Disable nvim-lspconfig's omnisharp setup
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				omnisharp = false, -- Disable it completely
			},
		},
	},
}
