#!/usr/bin/env bash

# Si tiene un error en la ejecucion se detiene
set -o errexit

# Si referencia a una variable no especificada es error
set -o nounset

echo "********* Script API de GithHub *********"
echo -n "Ingrese el usuario de GitHub a buscar: "
read -r user

# API
url="https://api.github.com/users/$user" 

# Obtengo los dato del API
response=$(curl -s "$url")

# Obtener valores del JSON
id=$(echo "$response"|jq '.id')
name=$(echo "$response"|jq '.name')
fecha_creacion=$(echo "$response"|jq '.created_at')

# Mensaje
Mensaje="Hola $name con id: $id, su cuenta fue creada el: $fecha_creacion"
echo "$Mensaje"

# Cambiamos al directorio de la carpeta
cd "tmp"

# Obtengo la fecha y hora actual
fecha_hora=$(date +%d-%m-%Y:%H-%M-%S)

# Crea la carpeta
mkdir "$fecha_hora"

cd "$fecha_hora"

# Nombre del archivo
archivo="saludos.log"

# Crea el archivo y le agrega el mensaje
echo "$Mensaje" > "$archivo"
