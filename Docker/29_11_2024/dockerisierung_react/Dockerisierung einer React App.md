# Dockerisierung einer React-App
    
```bash
npx create-react-app sample 
```
    
```
cd sample
```
---

### 2. Entwicklungsumgebung mit Docker

```Dockerfile
# Basis-Image
FROM node:20.18-alpine

# Arbeitsverzeichnis
WORKDIR /app

# Abhängigkeiten installieren
COPY package.json package-lock.json ./
RUN npm install --silent

# Code hinzufügen
COPY . ./

# App starten
CMD ["npm", "start"]

```

 `.dockerignore`-Datei

```plaintext
node_modules
build
.dockerignore
Dockerfile
```

```bash
docker buildx build -t sample:dev .
```


```bash
docker run \
    -it \
    --rm \
    -p 3001:3000 \
    sample:dev
```
- `--rm`: Löscht den Container nach der Beendigung.

---

### 3. Produktionsumgebung

`Dockerfile.prod` 
```Dockerfile
# Build-Umgebung
FROM node:20.18-alpine as build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci --silent
COPY . ./
RUN npm run build

# Produktionsumgebung
FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

```

1. **Build-Phase**:
   - Ein Node.js-Container wird verwendet, um die Abhängigkeiten zu installieren und das React-Projekt zu bauen.
   - Das React-Projekt wird mit `npm run build` in einen `build`-Ordner im Container erzeugt.

2. **Produktionsphase**:
   - Ein Nginx-Container wird verwendet, um die fertigen Build-Dateien zu hosten.
   - Die Build-Dateien werden aus der Build-Phase in das Nginx-Image kopiert.
   - Der Nginx-Webserver wird gestartet, um die fertigen Dateien als statische Ressourcen bereitzustellen.

```bash
docker build -f Dockerfile.prod -t sample:prod .
```

```bash
docker run -it --rm -p 1337:80 sample:prod
```

