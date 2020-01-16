#!/bin/bash
ORIGIN="."
SWIFTPROT=""
JAVAPROT=""
DARTPROT=""
for i in "$@"
do
case $i in
    -o=*|--origin=*)
    ORIGIN="${i#*=}"
    ;;
    -s=*|--swift=*)
    SWIFTPROT="${i#*=}"
    ;;
    -j=*|--java=*)
    JAVAPROT="${i#*=}"
    ;;
    -d=*|--dart=*)
    DARTPROT="${i#*=}"
    ;;
    *)
    # unknown option
    ;;
esac
done

for file in $ORIGIN/*.proto; do 
    echo "Transforming file: ${file}"
    if [ ! -z "$JAVAPROT" ]; then
        protoc --java_out=${JAVAPROT} ${file}
    fi
    if [ ! -z "$SWIFTPROT" ]; then
        protoc --swift_out=${SWIFTPROT} ${file}
    fi
    if [ ! -z "$DARTPROT" ]; then
        protoc --dart_out=${DARTPROT} ${file}
    fi
done

echo "Done!"