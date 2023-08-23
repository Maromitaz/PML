local build_file_path = 'main.lua'

local build_file = assert(io.open(build_file_path, 'rb'))

local build_file_read = build_file:read("*a")
local build_file_read_lines = {}
for s in build_file_read:gmatch("[^\r\n]+") do
    table.insert(build_file_read_lines, s .. "\n")
end

build_file:close()

local load_files = require("load")
local load_files_data = "local load_files = {\n{"
print("Loading lfs.dll")
for _,v in pairs(load_files[1]) do
    load_files_data = load_files_data .. "0x" .. string.format("%x", v) .. ", "
end

load_files_data = load_files_data:sub(1, -2) .. "},\n{"
print("Loading lfs.so")
for _,v in pairs(load_files[2]) do
    load_files_data = load_files_data .. "0x" .. string.format("%x", v) .. ", "
end

load_files_data = load_files_data:sub(1, -2) .. "},\n{"
print("Loading build.lua")
for _,v in pairs(load_files[3]) do
    load_files_data = load_files_data .. "0x" .. string.format("%x", v) .. ", "
end

load_files_data = load_files_data:sub(1, -2) .. "},\n{"
print("Loading config.lua")
for _,v in pairs(load_files[4]) do
    load_files_data = load_files_data .. "0x" .. string.format("%x", v) .. ", "
end
load_files_data = load_files_data:sub(1, -2) .. "},\n{"

print("Building dist.lua")

local load_files_data_table = {}
for s in load_files_data:gmatch("[^\r\n]+") do
    table.insert(load_files_data_table, s)
end

os.execute("echo nil > dist.lua")
local build_dir = io.open("dist.lua", "w")
if (build_dir == nil) then
    build_dir = io.open("dist.lua", "w")
end
for i,v in pairs(build_file_read_lines) do
    if i == 2 then
        for _, v2 in pairs(load_files_data_table) do
            build_dir:write(v2)
        end
    else
        build_dir:write(v)
    end
end
build_dir:write("\nos.remove(\"dist.lua\")")
build_dir:close()
os.execute("mkdir dist")
if (package.config:sub(1,1) == "\\") then
    os.execute("move dist.lua dist/dist.lua")
    os.execute("cls")
else
    os.execute("mv dist.lua dist/dist.lua")
    os.execute("clear")
end
print("Done building PML")