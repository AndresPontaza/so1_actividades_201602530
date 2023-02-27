# Actividad 3 - Solucionar un bug en container

Actualmente existe un bug en la container image de frontend del ejemplo visto en clase. Lo que sucede es que al momento de cargar una URL especifica se obtiene un error 404. La actividad consiste en entender y solucionar el problema. Subir la solución al folder indicado y crear un readme.md file explicando el problema y cual es su solución.

Link del repositorio: https://github.com/susguzman/so1_containers

## Analisis

Cuando el archivo **react.js** de la aplicación se carga, las rutas son manejadas en la interfaz por el **react-router**. En este caso http://localhost:3000/ y luego no dirigimos a http://localhost:3000/otro_sitio, Este cambio de ruta se maneja en el propio navegador. Ahora, cuando actualiza o abre la URL http://localhost:3000/otro_sitio una nueva pestaña, la solicitud va a **nginx** donde la ruta en particular no existe (debido a que react trabaja directamente con index.html y luego lo va cambiando en ejecucion por el DOM) y, por lo tanto, obtiene 404.

## Solucion 

### 1) Crear el archivo de configuraciones nginx lo llamare ***nginx.conf*** agregarlo en la raiz del repositorio.

```nginx=
server {
    listen       80;
    server_name  localhost;

    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
        try_files $uri /index.html;                 
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

### 2) Agregar las configruaciones de nginx al dockerfile del archivo ***nginx.Dockerfile*** del repositorio.

```dockerfile=
## BUILD
# docker build -t mifrontend:0.1.0-nginx-alpine -f nginx.Dockerfile .

## RUN
# docker run -d -p 3000:80 mifrontend:0.1.0-nginx-alpine
FROM node:18.14.0-buster-slim as compilacion

LABEL developer="jesus guzman" \
      email="susguzman@gmail.com"

ENV REACT_APP_BACKEND_BASE_URL=http://localhost:3800

# Copy app
COPY . /opt/app

WORKDIR /opt/app

# Npm install
RUN npm install

RUN npm run build

# Fase 2
FROM nginx:1.22.1-alpine as runner

### Cambio 1 ###
COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=compilacion /opt/app/build /usr/share/nginx/html

### Cambio 2 ###
CMD ["nginx", "-g", "daemon off;"]

```

### 3) Crear la imagen con los cambios y ejecutarla.

#### 3.1) Crear la imagen con los cambios.

```
docker build -t mifrontend:0.1.0-nginx-alpine -f nginx.Dockerfile .
```

#### 3.2) Ejecutar la imagen creada y con ello se resulve el problema.

```
docker run -d -p 3000:80 mifrontend:0.1.0-nginx-alpine
```
