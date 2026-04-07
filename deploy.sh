#!/bin/bash
ACTION=$1
INSTANCE_ID=$2
DIRECTORY=$3
BUCKET=$4

if [ -z "$ACTION" ] || [ -z "$INSTANCE_ID" ] || [ -z "$DIRECTORY" ] || [ -z "$BUCKET" ]; then
    echo "Uso: ./deploy.sh <accion> <instance_id> <directorio> <bucket>"
    exit 1
fi

python3 ec2/gestionar_ec2.py $ACTION $INSTANCE_ID
if [ $? -ne 0 ]; then
    echo "Error al ejecutar EC2"
    exit 1
fi

bash s3/backup_s3.sh $DIRECTORY $BUCKET
if [ $? -ne 0 ]; then
    echo "Error en backup S3"
    exit 1
fi
