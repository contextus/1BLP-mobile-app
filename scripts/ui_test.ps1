# Runs integration tests using Flutter Driver

# RUN ANDROID UI TEST

Write-Output "Installing emulator..."

Write-Output "y" | & $env:ANDROID_HOME\tools\bin\sdkmanager --install 'system-images;android-29;google_apis;x86'

Write-Output "no" | & $env:ANDROID_HOME\tools\bin\avdmanager create avd -n android_29_emulator -k 'system-images;android-29;google_apis;x86' --device "pixel_xl" --force

Write-Output "Starting emulator..."

Start-Job { & $env:ANDROID_HOME\emulator\emulator -avd android_29_emulator -no-snapshot } | & $env:ANDROID_HOME\platform-tools\adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed | tr -d '\r') ]]; do sleep 1; done; input keyevent 82'

Write-Output "Running UI test..."

flutter drive "test_driver/app.test"

Write-Output "Stopping emulator..."

& $env:ANDROID_HOME\platform-tools\adb -s emulator-5554 emu kill

Write-Output "Uninstalling emulator..."

& $env:ANDROID_HOME\tools\bin\avdmanager delete avd -n android_29_emulator

Write-Output "Finished UI test..."