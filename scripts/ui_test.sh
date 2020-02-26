# Runs integration tests using Flutter Driver

# RUN ANDROID UI TEST

echo "Installing emulator..."

echo "y" | $ANDROID_HOME/tools/bin/sdkmanager --install 'system-images;android-29;google_apis;x86'

echo "no" | $ANDROID_HOME/tools/bin/avdmanager create avd -n android_29_emulator -k 'system-images;android-29;google_apis;x86' --device 'pixel_xl' --force

$ANDROID_HOME/tools/bin/avdmanager list avd

echo "Starting emulator..."

nohup $ANDROID_HOME/emulator/emulator -avd android_29_emulator -no-snapshot > /dev/null 2>&1 &
$ANDROID_HOME/platform-tools/adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed | tr -d '\r') ]]; do sleep 1; done; input keyevent 82'

echo "Running Android UI test..."

flutter drive test_driver/app.dart

Write-Output "Finished Android UI test."

echo "Stopping emulator..."

$ANDROID_HOME/platform-tools/adb -s emulator-5554 emu kill

# RUN IOS UI TEST

npm install -g ios-sim

echo "Starting simulator..."

ios-sim start --devicetypeid "iPhone-11-Pro-Max, 13.3"

echo "Running iOS UI test..."

flutter drive test_driver/app.dart

echo "Finished iOS UI test"

echo "Stopping simulator..."

killall "Simulator"