# Actividad 4 - Systemd unit

Se ha creado un systemd unit tipo servicio para ejecutar un script que imprima un saludo y la fecha actual.
</br>

## Permisos
Tener en cuenta que debe estar en modo root o debe colocar `sudo` antes de cada comando.

## Archivo Script
Primero debe darle permisos al archivo **mi_script.sh**. 
`chmod +x /usr/local/bin/mi_script.sh`
</br>

Luego se agrega el archivo script.sh en el directorio `/usr/local/bin`.
</br>

## Archivo Unit
Agregar el archivo **actividad4.service** en el directorio `/etc/systemd/system`.
</br>

## Actualizar Systemd
Se debe volver a cargar la configuración del Systemd.
</br>

**Comando**
```shell
systemctl daemon-reload
```
</br>

## Iniciar Servicio
Se inicia el servicio con el siguiente comando.
</br>

**Comando**
```shell
systemctl start mi_servicio
```
</br>

## Ejecutar salida 
Finalmete se va a ejecutar de la siguente manera y por tanto va a mostrar el resultado del script.
</br>

**Comando**
```shell
systemctl status mi_servicio
```