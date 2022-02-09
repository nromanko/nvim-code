local api = vim.api
local utils = require('dap.utils')
local M = {}
local session = nil

local function readFile(filePath)

  local file = io.open(filePath, "r")
  local data = file:read("*a")
  file.close()

  return data
end

local homeDir = os.getenv("HOME")
local configsDir = homeDir .. '/.config/nvim-code'

-- Use a protected call so we don't error out on first use                                                                                                             
local status_ok, packer = pcall(require, "packer")                                                                                                                     
if not status_ok then                                                                                                                                                  
  return                                                                                                                                                               
end

M.setup = function()

  local options = vim.json.decode(readFile(configsDir .. '/settings.json'))

  for k, v in pairs(options) do
    vim.opt[k] = v
  end

  local plagins_json = vim.json.decode(readFile(configsDir .. '/plugins.json'))

  local plugins = {}
  
  for k, v in pairs(plagins_json) do
    packer.use(k)
  end

end

return M
