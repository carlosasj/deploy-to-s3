#!/bin/sh

set -x
set -e

if [[ '0' == $(aws s3 ls | grep "${AWS_S3_BUCKET}" | wc -l) ]]; then
    echo "ERRO:"
    echo "    Não existe o bucket ${AWS_S3_BUCKET}"
    exit 1
fi

aws s3 rm s3://$AWS_S3_BUCKET/ --recursive

aws s3 cp dist s3://$AWS_S3_BUCKET/ --recursive
