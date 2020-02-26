$files = Get-ChildItem -Directory

foreach ($f in $files) {
    $project_name = $f.Name

    Set-Location $project_name

    if (Test-Path "pubspec.yaml") {
        if (Test-Path "test") {
            Write-Output "Running tests in $project_name"
        
            flutter test --pub

        }
        else {
            Write-Output "test directory not found in $project_name, skipping..."
        }
    }
    else {
        Write-Output "pubspec.yaml file not found in $project_name, skipping..."
    }

    Set-Location ..
}