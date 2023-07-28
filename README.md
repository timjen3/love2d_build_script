# love2d_build_script

Just sharing a windows powershell script for building a Love2d game. Hopefully it saves someone else time too.

See Here: [Love2d.org](https://love2d.org/wiki/Game_Distribution#Creating_a_Windows_Executable)

## Pre-Reqs

You probably need to have .NET Framework installed on your machine.

Not recommending doing this, but because the file isn't signed you may need to allow execution of unsigned scripts to run it. This can be done for the current shell session like this: `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`
