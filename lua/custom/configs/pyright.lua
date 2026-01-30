local util = require("lspconfig.util")

return {
  on_init = function(client)
    local root_dir = client.config.root_dir
    print("Root dir: " .. root_dir)
    -- local venv_python = root_dir .. "/.venv/bin/python"
    local venv_python = "/usr/bin/python"

    if vim.fn.executable(venv_python) == 1 then
      client.config.settings.python.pythonPath = venv_python

      -- 🔍 Debug print
      vim.schedule(function()
        print("[Pyright] Using .venv python: " .. venv_python)
      end)
    else
      vim.schedule(function()
        print("Full path: " .. venv_python)
        -- print("[Pyright] No .venv/bin/python found. Using system default.")
      end)
    end
  end,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
    },
  },
  root_dir = util.root_pattern(".git", "pyproject.toml", "setup.py", "requirements.txt"),
}
