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

