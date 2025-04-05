local M = {}

function M.SplitPath(strFilename)
  -- Returns the Path, Filename, and Extension as 3 values
  return string.match(strFilename, "(.-)([^\\/]-([^\\/%.]+))$")
end

function M.GetAssociatedFiles()
  local file_path = vim.fn.expand("%")
  local path, file, extension = M.SplitPath(file_path)
  file = file:gsub("\n", "")
  file = file:gsub("Mock", "")
  file = file:gsub("Test", "")
  file = file:gsub(".h", "")
  file = file:gsub(".cpp", "")
  if #file > 0 then
    return file
  else
    return ''
  end
end

 function M.toggle_quickfix()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win["quickfix"] == 1 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end

return M
