#!/bin/bash

DOCKER () {
    if [ $type = 'SOURCE' ]; then  
        docker compose up -d --build xrpl-build
    elif [ $type = 'PREBUILT' ]; then
        docker compose up -d --build xrpl
    else
        echo 'Not a valid response. Try again.'
        exit 1
    fi
}

CHECK_INPUT() {
    echo "........."
    echo "Does everything look correct? 

    Build-Type: $type
    Node: $opt
    NetworkID: $netId

    To proceed, indicate [Y]/[n] "

    read x

    if [ $x = 'n' ]; then  
        echo "Exiting..."
        exit 1
    elif [ $x = 'Y' ]; then
        echo "Input validated. Proceeding to next step..."
    else
        echo 'Not a valid response. Try again.'
        exit 1
    fi
}

MAINNET() {
    echo "Moving MAINNET configuration files"

    rm -r ../images/xrpl/rippled.cfg
    rm -r ../images/xrpl/validators.txt

    cp ../config/xrpl/main/rippled.cfg ../images/xrpl
    cp ../config/xrpl/main/validators.txt ../images/xrpl
    DOCKER
    exit 1
}

TESTNET() {
    echo "Moving TESTNET configuration files"

    rm -r ../images/xrpl/rippled.cfg
    rm -r ../images/xrpl/validators.txt

    cp ../config/xrpl/test/rippled.cfg ../images/xrpl
    cp ../config/xrpl/test/validators.txt ../images/xrpl
    DOCKER
    exit 1
}

DEVNET() {
    echo "Moving DEVNET configuration files"

    rm -r ../images/xrpl/rippled.cfg
    rm -r ../images/xrpl/validators.txt

    cp ../config/xrpl/dev/rippled.cfg ../images/xrpl
    cp ../config/xrpl/dev/validators.txt ../images/xrpl
    DOCKER
    exit 1
}

XLS20() {
    echo "Moving XLS20 configuration files"

    rm -r ../images/xrpl/rippled.cfg
    rm -r ../images/xrpl/validators.txt

    cp ../config/xrpl/nft/rippled.cfg ../images/xrpl
    cp ../config/xrpl/nft/validators.txt ../images/xrpl
    cp ../config/xrpl/nft/Dockerfile.build ../images/xrpl
    DOCKER
    exit 1
}

echo "........."
PS3='Indicate whether to build from source or to build for prebuilt package:'
options=("Build from source" "Build from prebuilt image")
select i in "${options[@]}"
do
    case $i in
        "Build from source")
            type='SOURCE'
            break
            ;;
        "Build from prebuilt image")
            type='PREBUILT'
            break
            ;;
        "Exit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

echo "........."
PS3='Please select one of the possible xrpl nodes: '
options=("MAINNET" "TESTNET" "DEVNET" "XLS20")
select opt in "${options[@]}"
do
    case $opt in
        "MAINNET")
            netId=0
            CHECK_INPUT
            MAINNET
            ;;
        "TESTNET")
            netId=1
            CHECK_INPUT
            TESTNET
            ;;
        "DEVNET")
            netId=2
            CHECK_INPUT
            DEVNET
            ;;
        "XLS20")
            netId=20
            CHECK_INPUT
            XLS20
            ;;
        "Exit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
