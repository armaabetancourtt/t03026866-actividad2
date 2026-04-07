#!/bin/bash
if [ -f config/config.env ]; then
    source config/config.env
fi

ACTION=$1
INSTANCE_ID=${2:-$INSTANCE_ID}
DIRECTORY=${3:-$DIRECTORY}
BUCKET=${4:-$BUCKET_NAME}

LOG_FILE="logs/deploy.log"
mkdir -p logs

if [ -z "$ACTION" ] || [ -z "$INSTANCE_ID" ] || [ -z "$DIRECTORY" ] || [ -z "$BUCKET" ]; then
    echo "Uso: ./deploy.sh <accion> <instance_id> <directorio> <bucket>" | tee -a $LOG_FILE
    exit 1
fi

echo "[$(date)] Inicio del proceso" >> $LOG_FILE

echo "[$(date)] Ejecutando acción EC2: $ACTION" >> $LOG_FILE
python3 ec2/gestionar_ec2.py $ACTION $INSTANCE_ID
if [ $? -ne 0 ]; then
    echo "Error al ejecutar EC2" >> $LOG_FILE
    exit 1
fi

echo "[$(date)] Ejecutando backup en S3" >> $LOG_FILE
bash s3/backup_s3.sh $DIRECTORY $BUCKET
if [ $? -ne 0 ]; then
    echo "Error en backup S3" >> $LOG_FILE
    exit 1
fi

echo "[$(date)] Proceso finalizado correctamente" >> $LOG_FILE
