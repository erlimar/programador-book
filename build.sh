#!/bin/sh

# Copyright (c) E5R Development Team. All rights reserved.
# Licensed under the Apache License, Version 2.0. More license information in LICENSE.

set -eu

_has() {
    type "${1}" > /dev/null 2>&1
}

_show_log()
{
    echo "log: ${1}"
}
_show_error()
{
    echo "err: ${1}"
}

# check requirements
if ! _has "crowbook"; then
    _show_error "crowbook is required"
    exit 1
fi

if ! _has "xelatex"; then
    _show_error "xelatex is required"
    exit 1
fi

if ! _has "zip"; then
    _show_error "zip is required"
    exit 1
fi

clean() {
    if [ -d ./dist ]; then
        rm -rdf ./dist
    fi
}

make() {
    if [ ! -d ./dist ]; then
        mkdir ./dist
    fi
    crowbook src/programador.book
}

if [ "$#" != "0" ]; then
    if [ "$1" = "clean" ]; then
        _show_log "Cleaning..."
        clean
        exit 0
    fi

    if [ "$1" = "update-doc" ]; then
        _show_log "Updating docs/..."
        make && cp ./dist/programador-book.html ./docs/index.html
    fi
fi

_show_log "Making book..."
make

exit $?
