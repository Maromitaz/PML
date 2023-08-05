-- The project's name
local proj_name = "main"
-- The files to look for if auto_search is off
local files = "main.cpp ./core/touch/touch.c "
-- If you want to run the project after the compilation is done.
local run = false
-- Automatically search for .c and .cpp files in this project.
local auto_search = true
-- I'll let you guess what it does :)
local detect_compiler = false -- Only g++ or llvm clang++

return {proj_name, files, run, auto_search, detect_compiler}