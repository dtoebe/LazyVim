-- ~/.config/nvim/lua/plugins/razor-helpers.lua
return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		keys = {
			-- Quick navigation between razor and code-behind
			{
				"<leader>ra",
				function()
					local current_file = vim.fn.expand("%:p")
					local alternate_file

					if current_file:match("%.razor%.cs$") then
						-- From .razor.cs to .razor
						alternate_file = current_file:gsub("%.razor%.cs$", ".razor")
					elseif current_file:match("%.razor$") then
						-- From .razor to .razor.cs
						alternate_file = current_file .. ".cs"
					else
						vim.notify("Not a Razor file", vim.log.levels.WARN)
						return
					end

					if vim.fn.filereadable(alternate_file) == 1 then
						vim.cmd("edit " .. alternate_file)
					else
						vim.notify(
							"Alternate file not found: " .. vim.fn.fnamemodify(alternate_file, ":t"),
							vim.log.levels.WARN
						)
					end
				end,
				desc = "Toggle between .razor and .razor.cs",
			},

			-- Quick create code-behind
			{
				"<leader>rc",
				function()
					local current_file = vim.fn.expand("%:p")

					if not current_file:match("%.razor$") then
						vim.notify("Not a .razor file", vim.log.levels.WARN)
						return
					end

					local codebehind_file = current_file .. ".cs"

					if vim.fn.filereadable(codebehind_file) == 1 then
						vim.cmd("edit " .. codebehind_file)
						return
					end

					-- Create new code-behind file
					local component_name = vim.fn.fnamemodify(current_file, ":t:r")
					local namespace = vim.fn.input("Namespace: ", "PodcastApp.Pages")

					local template = string.format(
						[[
namespace %s;

public partial class %s : ComponentBase
{
    protected override async Task OnInitializedAsync()
    {
        await base.OnInitializedAsync();
    }
}
]],
						namespace,
						component_name
					)

					vim.fn.writefile(vim.split(template, "\n"), codebehind_file)
					vim.cmd("edit " .. codebehind_file)
				end,
				desc = "Create code-behind file",
			},
		},
	},
}
