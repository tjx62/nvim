return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
      })
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
          'lua_ls',
          'rust_analyzer',
          'bashls',
          'clangd',
          'docker_compose_language_service',
          'eslint',
          'biome',
          'ruff',
          'pyright',
        },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
    dependencies = {'hrsh7th/cmp-nvim-lsp'},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        -- Setting specific keybinds for LSPs. Will document them
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {}) -- Tells is about the item in a hovering window
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {}) -- Shows us the definitions of an item
        vim.keymap.set("n", "gr", vim.lsp.buf.references, {}) -- Shows all references to the symbol under my cursor
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {}) -- Jumps to the implementation of an iterface/trait/abstract method
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {}) -- Renames symbol under the cursor across all files
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {}) -- Jumps to the definition of symbol under the cursor
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {}) -- Shows diagnostics (errors, warning) in a floating window
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {}) -- Navigates through errors/warnings backwards
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {}) -- Navigates through errors/warnings forwards
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {}) -- Floating window showing quick code fixes
      end


			lspconfig.bashls.setup({
				capabilities = capabilities,
				filetypes = { "sh", "bash", "zsh" },
				settings = {
					bashIde = {
						globPattern = "*@(.sh|.inc|.bash|.command)",
					},
				},
			})

			lspconfig.ruff.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = { "ruff", "server" },
				filetype = { "python" },
				root_dir = function(fname)
					return require("lspconfig.util").root_pattern("pyproject.toml", "ruff.toml", ".ruff.toml")(fname)
						or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
				end,
				single_file_support = true,
				settings = {},
				init_options = {
					settings = {
						logLevel = "debug",
					},
				},
			})

			lspconfig.clangd.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--background-index",
					"--suggest-missing-includes",
					"--clang-tidy",
					"--header-insertion=iwyu",
				},
			})

			lspconfig.gopls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						usePlaceholders = true,
						completeUnimported = true,
					},
				},
			})

			lspconfig.biome.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					biome = {
						format = {
							enable = true,
						},
						lint = {
							enable = true,
						},
					},
				},
			})

			lspconfig.pyright.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
          pyright = {
            disableOragnizeImports = true,
          },
          python = {
            ignore = {'*'},
          },
				},
			})

			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			lspconfig.rust_analyzer.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						checkOnSave = {
							command = "clippy",
						},
						cargo = {
							allFeatures = true,
						},
						procMacro = {
							enable = true,
						},
						diagnostics = {
							enable = true,
							experimental = {
								enable = true,
							},
						},
					},
				},
			})
		end,
	},
}

