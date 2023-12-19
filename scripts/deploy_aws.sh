#!/bin/bash

scripts/create_lambda_package.sh
scripts/clean_up.sh

terraform -chdir=./terraform apply -auto-approve
