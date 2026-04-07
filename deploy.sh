#!/bin/bash
ACTION=$1
INSTANCE_ID=$2
DIRECTORY=$3
BUCKET=$4

if [ -z "$ACTION" ] || [ -z "$INSTANCE_ID" ]; then
    echo "Uso: ./deploy.sh <accion> <instance_id>"
    exit 1
fi

python3 ec2/gestionar_ec2.py $ACTION $INSTANCE_ID

if [ -z "$ACTION" ] || [ -z "$INSTANCE_ID" ] || [ -z "$DIRECTORY" ] || [ -z "$BUCKET" ]; then
    echo "Uso: ./deploy.sh <accion> <instance_id> <directorio> <bucket>"
    exit 1
fi

bash s3/backup_s3.sh $DIRECTORY $BUCKET
