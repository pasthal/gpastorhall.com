# Define the paths to the repositories
$sourcePath = "E:\halgory.com"
$destinationPath = "E:\gpastorhall.com"

# Ensure the destination directory exists
if (!(Test-Path -Path $destinationPath)) {
    New-Item -ItemType Directory -Path $destinationPath
}

# Copy all contents from the source to the destination, excluding the .git directory
Get-ChildItem -Path $sourcePath -Recurse | Where-Object { $_.FullName -notmatch '\\.git' } | ForEach-Object {
    $dest = $_.FullName -replace [regex]::Escape($sourcePath), [regex]::Escape($destinationPath)
    if ($_.PSIsContainer) {
        New-Item -ItemType Directory -Path $dest -Force
    } else {
        Copy-Item -Path $_.FullName -Destination $dest -Force
    }
}

# Confirm the copy
Write-Output "All contents from '$sourcePath' have been copied to '$destinationPath'."

# If you want to also copy the .gitignore and .gitattributes files, uncomment the following lines
# Copy-Item -Path "$sourcePath\.gitignore" -Destination "$destinationPath\.gitignore" -Force
# Copy-Item -Path "$sourcePath\.gitattributes" -Destination "$destinationPath\.gitattributes" -Force
