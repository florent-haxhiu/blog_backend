#!/bin/bash

cd ..

poetry build
poetry run pip install --upgrade -t package dist/*.whl
cd package || exit
zip -r ../artifact.zip . -x '*.pyc'
