# Gallery Manifest Updater
# Run this script after adding/removing images in assets/gallery to update the website

$galleryPath = "assets/gallery"
$manifestPath = "gallery_manifest.json"

# Get all image files
$images = Get-ChildItem -Path $galleryPath -Include *.jpg, *.jpeg, *.png, *.webp, *.gif -Recurse

# Create a list of relative paths (formatted for JSON)
$jsonList = @()
foreach ($img in $images) {
    # Convert backslashes to forward slashes for web URL compatibility
    $relativePath = "assets/gallery/" + $img.Name
    $jsonList += "`"$relativePath`""
}

# Join into a JSON array string
$jsonContent = "[" + [System.Environment]::NewLine + ($jsonList -join "," + [System.Environment]::NewLine) + [System.Environment]::NewLine + "]"

# Write to file
Set-Content -Path $manifestPath -Value $jsonContent

Write-Host "Gallery manifest updated successfully! Found $($images.Count) images."
Start-Sleep -Seconds 3
