$files = Get-ChildItem -Directory

foreach ($f in $files) {
    $project_name = $f.Name

    Set-Location $project_name

    if (Test-Path "pubspec.yaml") {
        Write-Output "Cleaning project $project_name"
        flutter clean build
        flutter packages get
    }

    else {
        Write-Output "'pubspec.yaml' file not found in $project_name, skipping..."
    }

    Set-Location ..
}