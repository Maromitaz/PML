-- Loading DLLs and SOs
local load_files = require("load")

-- These vars are being used to write to file the dll/so, build file and config file.
local dll_so_out = ""
local build_lua_bytes = load_files[3]
local build_lua = ""
local config_lua_bytes = load_files[4]
local config_lua = ""

local temp_str = ""
local dll_so_out_content = ""

-- Detecting the os, Windows or Linux ofc.
if(package.config:sub(1,1) == "\\") then
  load_files = load_files[1]
  dll_so_out = "lfs.dll"
else
  load_files = load_files[2]
  dll_so_out = "lfs.so"
end

-- Converting the bytes to file. Byte to dll/so.
for _,v in pairs(load_files) do
  temp_str = string.char(v)
  dll_so_out_content = dll_so_out_content .. temp_str
end
temp_str = ""

-- Converting bytes to build.lua.
for _,v in pairs(build_lua_bytes) do
  temp_str = string.char(v)
  build_lua = build_lua .. temp_str
end
temp_str = ""

-- Converting bytes to config.lua.
for _,v in pairs(config_lua_bytes) do
  temp_str = string.char(v)
  config_lua = config_lua .. temp_str
end
temp_str = ""

-- Writing to file the .dll or .so
local out = io.open(dll_so_out, "wb")
out:write(dll_so_out_content)
out:close()
os.execute("mkdir lfs")

if(package.config:sub(1,1) == "\\") then
	os.execute("move " .. dll_so_out .. " lfs/")
else
	os.execute("mv " .. dll_so_out .. " lfs/")
end

local out = io.open("build.lua", "wb")
out:write(build_lua)
out:close()

local out = io.open("config.lua", "wb")
out:write(config_lua)
out:close()