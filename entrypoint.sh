#!/bin/sh

set -x
set -e

if [[ '0' == $(aws s3 ls | grep "${AWS_S3_BUCKET}" | wc -l) ]]; then
    echo "ERRO:"
    echo "    Não existe o bucket ${AWS_S3_BUCKET}"
    exit 1
fi

DISTPATH=$([[ $PATH_TO_REPLACE ]] && echo /$PATH_TO_REPLACE || echo '')
_RECURSIVE=$([[ ${RECURSIVE:-TRUE} == "TRUE" ]] && echo '--recursive' || echo '')

aws s3 rm s3://$AWS_S3_BUCKET/$PATH_TO_REPLACE $_RECURSIVE
aws s3 cp dist$DISTPATH s3://$AWS_S3_BUCKET/$PATH_TO_REPLACE $_RECURSIVE $(printenv EXTRA_FLAGS)
