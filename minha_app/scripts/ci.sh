#!/usr/bin/env bash

# run function in all dirs
# expects a function name
allDirs() {
    dirs=(`find . -maxdepth 2 -type d`)
    for dir in "${dirs[@]}"; do
        $1 $dir
    done
}

runGet() {
    cd $1
    if [ -f "pubspec.yaml" ]; then
        flutter packages get
    fi
    cd - > /dev/null
}



runClean() {
    cd $1;
    if [ -f "pubspec.yaml" ]; then
        echo "run clean in $1"
        flutter clean > /dev/null
        rm -rf ios/Pods ios/Podfile.lock
        rm -rf android/.gradle
        rm -rf coverage
    fi
    cd - > /dev/null
}

# if no arguments passed
case $1 in
    --get)
        allDirs "runGet"
        ;;
    --clean)
        allDirs "runClean"
        ;;
    *)
esac