-- Detecting the operating system: Windows or GNU/Linux (or alpine if you're quirky)
local is_windows = false
if(package.config:sub(1,1) == "\\") then
  is_windows = true
end

-- Loading external files
if (is_windows) then
  package.cpath = package.cpath .. "./lfs/?.dll"
else
  package.cpath = package.cpath .. "./lfs/?.so"
end
local lfs  = require("lfs")    -- lua file system
local conf = require("config") -- the configurations

-- The source files
_G["files"] = conf[2]

-- Project name
local proj = conf[1]

-- The compiler used.
local CC = "g++ "

-- The arguments used to produce the binary.
local ARGS = "-Wall -O2 -o "

-- The destination folder & name.
local dest = "./build/"

-- If you want to use gdb and debug the program, just make it true.
local b_debug = false

for i in pairs(arg) do
  if(arg[i] ~= nil) then
    if(arg[i]:sub(1,1) == "-" or arg[i]:sub(1,2) == "--") then
      if (arg[i] == "-d" or arg[i] == "--debug") then
        b_debug = true
      else
        print("Unknown argument: " .. arg[i]) 
      end
    end
  end
end

local debug = ""
if b_debug then
  debug = "-g "
  dest = dest .. "debug/"
else
  dest = dest .. "release/"
end

-- Just in case if you're using an older version of lua
if (table.unpack == nil) then
  table.unpack = unpack
end

-- Detects your compiler. Only g++ or llvm clang++
if (conf[5]) then
  os.execute("echo \"int main(){return 0;}\" > detect.c")
  local exec = os.execute("g++ detect.c")
  if(exec ~= 0) then
    exec = os.execute("clang++ detect.c")
    if(exec ~= 0) then
      os.execute("del detect.c")
      print("No g++ nor clang++ found. ")
      print("For now it will only support gnu and llvm C++ compilers. (g++ and clang++)")
      print("I'm sorry for the inconvenience but oh well... I'm lazy.")
      os.exit(1)
    end
    CC = "clang++ "
  end
  CC = "g++ "
  os.execute("del detect.c a.exe")
end


-- A simple lambda function that puts all the directories inside a 
-- directory into "dirs" table and all the .c/.cpp files in a "files" table
local total_files = (function (path)
  local dirs = {}
  local files = {}
  local search_path = path
  local dir_in_a_dir = true
  if (path == ".") then
    search_path = lfs.currentdir()
  end
  for file in lfs.dir(search_path) do
    if (file ~= '.' and file ~= '..') then
      if (lfs.attributes(search_path.."/"..file, "mode") == "directory" and
          file ~= "build" and file ~= "dist"
      ) then
        table.insert(dirs, file)
        dir_in_a_dir = false
      else
        local ext = file:match("[^.]+$")
        if (ext == "c" or ext == "cpp") then
          table.insert(files, file)
        end
      end
    end
  end
  return dirs, files, dir_in_a_dir
end)

-- Searches if autoSearch is enabled for all the files inside of this project.
if (conf[4]) then
  _G["files"] = ""
  local dirs, files, dir_in_a_dir = total_files(".")
  for _, file in pairs(files) do
    _G["files"] = _G["files"] .. " " .. file
  end
  local dir = dirs[1]
  local prev_dir = ""
  local temp_dirs, temp_files
  while (dir ~= nil) do
    dir = dirs[1]
    if(dir ~= nil) then
      temp_dirs, temp_files, dir_in_a_dir = total_files(prev_dir..dir)
      for _, file in pairs(temp_files) do
        _G["files"] = _G["files"] .. " ./" .. prev_dir .. dir.. "/" .. file .. " "
      end
      for _, temp_dir in pairs(temp_dirs) do
        table.insert(dirs, temp_dir)
      end
      prev_dir = dir .. "/"
      if (dir_in_a_dir) then
        prev_dir = ""
      end
      table.remove(dirs, 1)
    end
  end
end

-- Detects if ther is a build directory
local f = io.open(dest, "r")
if(f ~= nil) then
  f:close()
else
 os.execute("mkdir \"" .. dest .. "\"")
end

-- Detects if it is a windows machine. If true a ".exe" will be added at the end of the file.
if (is_windows) then
  proj = proj .. ".exe"
end

-- The command that compiles the project.
local command = CC .. files .. ARGS .. dest .. proj .. " " .. debug

os.execute(command)

print(command)

if (conf[3]) then
  os.execute(dest..proj)
end
