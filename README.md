
# Project made in lua (PML)

This is a project that compiles C/C++ code (with the gnu/cmake c++ compiler) just like the MS project builder but without a GUI.


## Useful information

#### Is it easy to use?

 If all you want to do is build with this project, then yes.

#### Contribution

Why? This is just a random side project that I won't touch ever (maybe add support for compiling just C code, but otherwise I won't touch this project).

#### Is this a good builder?

No, you're better of using CMAKE, Make (for linux) or [MSV](https://visualstudio.microsoft.com/) (Windows) and whatever is for mac.
## Requirements

- Lua 5.1 or newer
## Getting your hands on it

### Compressing

Firstly, copy the files with
```bash
git clone https://github.com/Maromitaz/PML.git
```
(Requires the [git](https://github.com/git/git) cli)\
To make this project that builds projects just run

```bash
  lua build.lua
```

And the compressed file should be in the "dist" directory.

### Running

To generate the necessary files (build.lua, config.lua and the [lfs](https://github.com/lunarmodules/luafilesystem) .dll or .so) simply run:

```bash
  lua dist.lua
```

The dist.lua will be deleted and there should be just the necessary files.

### Building a C++ project

Take a look in the config.lua file and change the settings to your liking.\
Everything is explained by a short comment.

After that just run the build.lua just like you've compressed the files. It's not compressing it's compiling the c/c++ files. I know it's confusing. Will I fix this? Probably.

```bash
lua build.lua
```

And if you want to compile your code for debugging reasons just add -d or --debug as an argument. Any other argument should just tell in the terminal that it's not an argument.

The built files are located in the build directory created by the lua file. It's build/release for
```bash
lua build.lua
```
and build/debug for
```bash
lua build.lua -d
```
or
```bash
lua build.lua --debug
```
## License

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <https://unlicense.org>
