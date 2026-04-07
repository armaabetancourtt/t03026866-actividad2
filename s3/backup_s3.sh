#!/bin/bash

DIRECTORIO=$1
BUCKET=$2
FECHA=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVO="backup_$FECHA.tar.gz"
LOG="logs/backup.log"

mkdir -p logs

if [ -z "$DIRECTORIO" ] || [ -z "$BUCKET" ]; then
  echo "Uso: ./backup_s3.sh <directorio> <bucket>"
  echo "[$FECHA] Error: parámetros incorrectos" >> $LOG
  exit 1
fi

if [ ! -d "$DIRECTORIO" ]; then
  echo "Directorio no existe"
  echo "[$FECHA] Error: directorio no existe: $DIRECTORIO" >> $LOG
  exit 1
fi

tar -czf $ARCHIVO $DIRECTORIO

if [ $? -ne 0 ]; then
  echo "Error al comprimir"
  echo "[$FECHA] Error al comprimir $DIRECTORIO" >> $LOG
  exit 1
fi

echo "[$FECHA] Compresión exitosa: $ARCHIVO" >> $LOG
