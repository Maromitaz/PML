-- Getting the mail file that is building the builder
local build_file_path = 'main.lua'
-- Opening a handle for the main file
local build_file = assert(io.open(build_file_path, 'rb'))
-- Reading the data from the given handle
local build_file_read = build_file:read("*a")
local build_file_read_lines = {}
-- Detecting every new line in the file and then it is being placed into
-- a table with a new line at the end.
for s in build_file_read:gmatch("[^\r\n]+") do
    table.insert(build_file_read_lines, s .. "\n")
end
-- Closing the handle
build_file:close()
-- Reading the "load" module instead of reading the bytes of it to easily
-- incorporate the code inside of the main file.
local load_files = require("load")
local load_files_data = "local load_files = {\n{"
-- From now on it'll do a for loop for every item inside of the load module.
-- A better idea would be to make a for loop inside of a for loop. I might do that.
for _,v in pairs(load_files[1]) do
    load_files_data = load_files_data .. "0x" .. string.format("%x", v) .. ", "
end
load_files_data = load_files_data:sub(1, -2)
load_files_data = load_files_data .. "},\n{"
for _,v in pairs(load_files[2]) do
    load_files_data = load_files_data .. "0x" .. string.format("%x", v) .. ", "
end
load_files_data = load_files_data:sub(1, -2)
load_files_data = load_files_data .. "},\n{"
for _,v in pairs(load_files[3]) do
    load_files_data = load_files_data .. "0x" .. string.format("%x", v) .. ", "
end
load_files_data = load_files_data:sub(1, -2)
load_files_data = load_files_data .. "},\n{"
for _,v in pairs(load_files[4]) do
    load_files_data = load_files_data .. "0x" .. string.format("%x", v) .. ", "
end
-- Deleting the last ","
load_files_data = load_files_data:sub(1, -2)
load_files_data = load_files_data .. "}\n}\n"
-- I'm not going to lie, I've forgot the use of this.
local load_files_data_table = {}
for s in load_files_data:gmatch("[^\r\n]+") do
    table.insert(load_files_data_table, s)
end
-- The making of "dist.lua" file
os.execute("echo nil > dist.lua")
-- Opening the handle for the file
local build_dir = io.open("dist.lua", "w")
-- I don't know why this is here, maybe I've forgot to delete.
-- At this point I'm too afraid to touch this so it'll stay here.
if (build_dir == nil) then
    build_dir = io.open("dist.lua", "w")
end
-- Writing every line inside the file
for i,v in pairs(build_file_read_lines) do
    if i == 2 then
        for i2, v2 in pairs(load_files_data_table) do
            build_dir:write(v2)
        end
    else
        build_dir:write(v)
    end
end
-- Writing inside of the dist.lua os.remove(itself) because it's useless there :D 
build_dir:write("\nos.remove(\"dist.lua\")")
-- Closing handle for dist.lua
build_dir:close()
os.system("mkdir dist")
-- Detecting OS and moving the dist.lua inside of the dist directory created on the
-- previous line.
if (package.config:sub(1,1) == "\\") then
    os.execute("move dist.lua dist/dist.lua")
else
    os.execute("mv dist.lua dist/dist.lua")
end
