# Define $BUILD_BUILDNAME and $BUILD_BUILDNUMBER as Azure Pipeline Variables

# BUILD iOS

flutter build ios --build-name=$BUILD_BUILDNAME --build-number=$BUILD_BUILDNUMBER --target="lib/main_release_dev.dart" --codesign

# BUILD ANDROID

flutter build apk --build-name=$BUILD_BUILDNAME --build-number=$BUILD_BUILDNUMBER --target="lib/main_release_dev.dart"