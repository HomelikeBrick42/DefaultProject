@echo off
SetLocal EnableDelayedExpansion

call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x64

set files=
pushd ./src
for /r %%f in (*.cpp) do (
	if "%%~xf"==".cpp" set files=!files! %%f
)
for /r %%f in (*.c) do (
	if "%%~xf"==".c" set files=!files! %%f
)
popd

set includeDirs=/I %CD%\src
set name=DefaultProject
set stack=-STACK:0x100000,0x100000
set ignoredWarnings=-wd4281 -wd4100 -wd4189 -wd4200 -wd4101
set libs=kernel32.lib user32.lib gdi32.lib
set defines=-DWINDOWS=1 -DSLOW=1 -DRELEASE=0

if not exist build mkdir build
pushd build
cl -fp:fast -fp:except- -nologo -GS- -Gs2147483647 -Gm- -GR- -EHa- -Oi -WX -W4 %includeDirs% %ignoredWarnings% %defines% -FC -Z7 -Fm%name%.map %files% /link /NODEFAULTLIB -entry:Main -subsystem:windows -incremental:no -opt:ref %stack% %libs% /OUT:%name%.exe
popd
