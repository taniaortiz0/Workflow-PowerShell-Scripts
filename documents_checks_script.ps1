# NOTE: I have placed some Foreground colors for user readability.

# Set the Downloads Directory

$DocumentsDir = "$env:USERPROFILE\Documents" #You can add \OneDrive before the \Downloads to display the contents of the Downloads directory with OneDrive included..

Write-Host "Contents of the Documents folder:" -ForegroundColor Gray
Write-Host "---------------------------------"

# Get all files in Downloads and Subfolders

Get-ChildItem -Path $DocumentsDir -File -Recurse | Select-Object Name, CreationTime, LastAccessTime, LastWriteTime

#Making into a pointer/reference into the collection of objects

$Files = Get-ChildItem -Path $DocumentsDir -File -Recurse | Select-Object Name, CreationTimLastAccessTime, LastWriteTime

#Detecting duplicate copies

$copyFiles = $Files | Where-Object { $_.Name -match '\(\d+\)' }

if ($copyFiles.Count -gt 0) {

    Write-Host "`nDisplaying duplicate copies:" -ForegroundColor Yellow
    Write-Host "---------------------------------"

    $copyFiles | Format-Table Name, LastAccessTime

  # Prompt for deletion one-by-one

    foreach ($file in $copyFiles) {
        $prompt = Read-Host "`nDo you want to delete this file?`n$($file.Name)`n[Y/N]"
        if ($prompt -eq 'Y') {
            try {
                Remove-Item -Path $file.Name -Force
                Write-Host "Deleted: $($file.Name)" -ForegroundColor Green
            } catch {
                Write-Host "Failed to delete: $($file.Name) -- $_" -ForegroundColor Red
            }
        } else {
            Write-Host "Skipped deletion for: $($file.Name)" -ForegroundColor Yellow
        }
    }
    Write-Host "`nPrompt-based deletion complete." -ForegroundColor Cyan

 # If no duplicate copies were found

} else {
    Write-Host "`nNo duplicate copies found." -ForegroundColor Green
}