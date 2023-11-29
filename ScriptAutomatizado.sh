#!/bin/bash

cd /home/seguridad/RespaldoBBDD/

last_commit_message=$(git log -1 --pretty=%B)

last_backup_number=$(echo "$last_commit_message" | grep -oP '\bRespaldo \K\d+' || echo 0)

new_backup_number=$((last_backup_number + 1))

mysqldump -u seguridad -pseguridad --databases Evaluacion4 > /home/seguridad/RespaldoBBDD/Respaldo${new_backup_number}.sql

max_respaldos=1
num_respaldos=$(ls -1 Respaldo*.sql | wc -l)
if [ "$num_respaldos" -gt "$max_respaldos" ]; then
    cantidad_a_eliminar=$((num_respaldos - max_respaldos))
    ls -1t Respaldo*.sql | tail -n "$cantidad_a_eliminar" | xargs rm
fi

git add .

git commit -m "Respaldo ${new_backup_number}"

git push origin main

