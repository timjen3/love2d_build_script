# Set Constants
$LOVE_DIR = "C:\Program Files\love"
$GAME_NAME = "mygame"

# Load the .NET assembly
Add-Type -Assembly 'System.IO.Compression'
Add-Type -Assembly 'System.IO.Compression.FileSystem'

# Must be used for relative file locations with .NET functions instead of Set-Location:
[System.IO.Directory]::SetCurrentDirectory($ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath('.\'))

# Create Zip File
Remove-Item -Recurse './bin'
New-Item -Name "bin" -ItemType "directory"
$z = [System.IO.Compression.ZipFile]::Open("${GAME_NAME}.love", [System.IO.Compression.ZipArchiveMode]::Create)

# Add Files to Zip Archive
$EXCLUDED_FILES = 'build.ps1', "${GAME_NAME}.love", '.keep'
Get-ChildItem -File -Recurse | Foreach-Object {
	if ($EXCLUDED_FILES -notcontains $_.Name) {
		$relativePath = Get-Item $_.FullName | Resolve-Path -Relative
		$relativePath = $relativePath.replace("\", "/").replace("./", "")
		echo $_.FullName
		echo $relativePath
		[System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($z, $_.FullName, $relativePath)
	}	
}

# Close the file
$z.Dispose()

# create executable
cmd /c copy /b $("${LOVE_DIR}\love.exe")+$("${GAME_NAME}.love") $(".\bin\${GAME_NAME}.exe")

# Copy Love Files Into Bin
Copy-Item -Path "${LOVE_DIR}/SDL2.dll" "./bin/"
Copy-Item -Path "${LOVE_DIR}/OpenAL32.dll" "./bin/"
Copy-Item -Path "${LOVE_DIR}/license.txt" "./bin/"
Copy-Item -Path "${LOVE_DIR}/love.dll" "./bin/"
Copy-Item -Path "${LOVE_DIR}/lua51.dll" "./bin/"
Copy-Item -Path "${LOVE_DIR}/mpg123.dll" "./bin/"
Copy-Item -Path "${LOVE_DIR}/msvcp120.dll" "./bin/"
Copy-Item -Path "${LOVE_DIR}/msvcr120.dll" "./bin/"

# Clean Up
Remove-Item "${GAME_NAME}.love"
