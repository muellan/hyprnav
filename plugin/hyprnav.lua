local function set_user_var(name, value)
  local payload = value and ("%s=%s"):format(name, vim.base64.encode(value)) or name
  -- in nvim ≥0.10 the UI is a separate process; stderr reaches the terminal
  vim.api.nvim_chan_send(vim.v.stderr, ("\27]1337;SetUserVar=%s\7"):format(payload))
end

local function publish()
  if vim.v.servername == "" then vim.fn.serverstart() end
  set_user_var("nvim_server", vim.v.servername)
end
local function retract() set_user_var("nvim_server", nil) end

local g = vim.api.nvim_create_augroup("navigate", {})
vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, { group = g, callback = publish })
vim.api.nvim_create_autocmd({ "VimLeavePre", "VimSuspend" }, { group = g, callback = retract })

---@param dir "h"|"j"|"k"|"l"
---@return integer 1 if focus moved
function _G.Navigate(dir)
  local before = vim.api.nvim_get_current_win()
  vim.cmd.wincmd(dir)
  return before ~= vim.api.nvim_get_current_win() and 1 or 0
end
