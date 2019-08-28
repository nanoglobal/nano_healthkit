#!/bin/bash
for i in "$@"
do
case $i in
    -p=*|--proto=*)
    PROTO="${i#*=}"

    ;;
    -s=*|--swift=*)
    SWIFT="${i#*=}"

    ;;
    -d=*|--dart=*)
    DART="${i#*=}"
    protoc --dart_out=${DART} ${PROTO}
    ;;
    *)
    # unknown option
    ;;
esac
done
echo PROTO PATH = ${PROTO}
echo SWIFT PATH = ${SWIFT}
echo DART PATH = ${DART}