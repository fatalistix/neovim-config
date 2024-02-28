-- gopher.nvim. Плагин для golang
-- https://github.com/olexsmir/gopher.nvim
return {
	"olexsmir/gopher.nvim",
	 config = function()
	 	require("gopher").setup()
	 end
}