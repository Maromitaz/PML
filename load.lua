local files_to_read = {
	"./external/lfs.dll",
	"./external/lfs.so",
	"./src/build.lua",
	"./src/config.lua"
}

local contents = {}
local contents_binary = {}
local function readBinaryFile(filename)
	local file = io.open(filename, "rb")
	if not file then
		return nil
	end
	local content = file:read("*a")
	file:close()
	return content
end

for _, file in pairs(files_to_read) do
	local file_reader = readBinaryFile(file)
	if file_reader then
		for i = 1, #file_reader do
			local byte = file_reader:byte(i)
			table.insert(contents_binary, byte)
		end
	else
		error("Failed to read the file.")
	end
	table.insert(contents, contents_binary)
end

return contents
