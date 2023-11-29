#!/bin/bash

# Cambiar al directorio del repositorio Git
cd /home/seguridad/RespaldoBBDD/

# Obtener el último mensaje de commit
last_commit_message=$(git log -1 --pretty=%B)

# Extraer el número del respaldo del mensaje del commit anterior
last_backup_number=$(echo "$last_commit_message" | grep -oP '\bRespaldo \K\d+' || echo 0)

# Incrementar el número del respaldo para el nuevo commit
new_backup_number=$((last_backup_number + 1))

# Respaldar la base de datos MySQL
mysqldump -u seguridad -p seguridad --databases Evaluacion4 > /home/seguridad/RespaldoBBDD/Respaldo${new_backup_number}.sql

# Agregar los cambios al repositorio Git
git add .

# Realizar un commit con un mensaje incremental
git commit -m "Respaldo ${new_backup_number}"

# Hacer un push al repositorio remoto (cambiar "main" por el nombre de tu rama si es diferente)
git push origin main

