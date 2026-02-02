#!/bin/bash

FW_DIR="lkg-stm32"
BUILD_NUM="0"
FW_VER="v0.00"
FW_PREFIX=""

TARGET=( "go_stm32" )
TARGET_DEFINE=( "go" )

function buildnum_insert {
    def="#define CI_BUILD_NUM "
    val=${BUILD_NUM}
    file=ci.h
    echo "Inserting build number ("$BUILD_NUM")"
    sed -i "s/${def}.*/${def}${val}/g" $file
}

function fwver_insert {
    def="#define CI_FW_VER "
    if [[ $FW_VER =~ ^v ]]; then 
        FW_VER="${FW_VER:1}";
        FW_PREFIX="v"
    fi
    val='"'${FW_VER}'"'
    file=ci.h
    echo "Inserting fwver number ("$FW_VER")"
    sed -i "s/${def}.*/${def}${val}/g" $file
}

function runmake {
    echo "Cleaning Up"
    make clean

    echo "Making"
    make $1
}

OUTPUT_DIR="./output"

# parse command line arguments
while getopts ":n:v:o:h" opt; do
    case ${opt} in
    h)
        echo "$0 -n <build_number> -v <firmware_version>"
        exit 1
        ;;
    n )
        BUILD_NUM=$OPTARG
        ;;
    v )
        FW_VER=$OPTARG
        ;;
    o )
        BUILD_OUTPUT=$OPTARG
        ;;
    \? )
        echo "Invalid option: $OPTARG" 1>&2
        exit 1
        ;;
    : )
        echo "Invalid option: $OPTARG requires an argument" 1>&2
        exit 1
        ;;
    esac
done
shift $((OPTIND -1))


cd ${FW_DIR} || exit

# Prepare output directory
[ -d $OUTPUT_DIR ] || mkdir $OUTPUT_DIR
rm -f $OUTPUT_DIR/*.bin

buildnum_insert
fwver_insert

targetindex=0
for i in "${TARGET[@]}"
do
    echo "################################"
    echo "Building (${i})"
    echo "################################"
    runmake "${TARGET_DEFINE[$targetindex]}"
    BUILD_OUTPUT="${TARGET[$targetindex]}"
    FW_FILENAME=${BUILD_OUTPUT}_${FW_PREFIX}${FW_VER}_build-${BUILD_NUM}
    cp build/output.bin ${OUTPUT_DIR}/${FW_FILENAME}.bin
    targetindex=$targetindex+1
done
