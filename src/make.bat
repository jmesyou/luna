gcc srlua/glue.c -o srlua/glue
gcc srlua/srlua.c -o srlua/srlua

srlua/glue.exe srlua/srlua.exe mune.lua mune.exe
