for d in **/; do

    cd "$d"

    if [ ! -f "pubspec.yaml" ]; then
        echo "'pubspec.yaml' file not found in $d, skipping..."
    else
        flutter clean build
        flutter packages get
    fi

    cd ..
done