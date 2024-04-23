#!/bin/bash

filename="artifact.zip"

if [ -e "$filename" ]; then
    rm artifact.zip
    echo "File '$filename' found and now deleted"
else
    printf "File %s not found\nNow creating new zip", $filename
fi

poetry build
poetry run pip install --upgrade -t package dist/*.whl
cd package || exit
zip -r ../artifact.zip . -x '*.pyc'
