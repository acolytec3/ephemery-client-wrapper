#!/bin/bash

client_datadir="~/.local/share/teku"

client_args="$@"
while [[ $# -gt 0 ]]; do
    case $1 in
    --data-path=*)
        client_datadir="${1#*=}"
        ;;
    --data-path)
        client_datadir="${2}"
        ;;
    esac
    shift
done

source /wrapper/wrapper.lib.sh

start_client() {
    /opt/teku/bin/teku $client_args
}

reset_client() {
    rm -rf $client_datadir/*
}

ephemery_wrapper "teku" "$client_datadir" "reset_client" "start_client"
