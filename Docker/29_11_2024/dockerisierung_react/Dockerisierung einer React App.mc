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

Erklärung der Parameter:

- `-it`: Startet den Container im interaktiven Modus.
- `--rm`: Löscht den Container nach der Beendigung.
- `-p 3001:3000`: Mappt den Port 3000 des Containers auf Port 3001 des Hosts.

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

Der Vorteil dieses *Multi-Stage Build*-Ansatzes ist, dass er die endgültige Image-Größe reduziert, da nur das Nötigste (der fertige `build`-Ordner) im Produktions-Container bleibt. Der Node.js-Teil und die Build-Werkzeuge sind nicht notwendig, sobald das Build abgeschlossen ist.
### 1. **Build-Umgebung**

- **`FROM node:13.12.0-alpine`**: Diese Zeile legt das Basis-Image für den Build fest. Es handelt sich um ein leichtgewichtiges Alpine-Linux-Image, das Node.js in der Version 13.12.0 enthält.
- **`as build`**: Dieser Teil benennt den Schritt als `build`. Das ist ein sogenannter *Multi-Stage Build*. Das bedeutet, dass Docker mehrere Phasen durchläuft, wobei in einer Phase (wie hier) der Build erstellt wird, und in einer späteren Phase nur das Resultat (z. B. das React-Build) verwendet wird. Dadurch wird die finale Docker-Image-Größe kleiner, weil unnötige Dateien (z. B. Build-Tools) nicht in das endgültige Image übernommen werden.

- **`WORKDIR /app`**: Diese Zeile setzt das Arbeitsverzeichnis im Container auf `/app`. Alle folgenden Befehle werden in diesem Verzeichnis ausgeführt. Wenn das Verzeichnis nicht existiert, wird es automatisch erstellt. Alle nachfolgenden Dateien und Ordner werden relativ zu diesem Verzeichnis bearbeitet.

- **`COPY package.json package-lock.json ./`**: Kopiert die `package.json` und `package-lock.json` Dateien vom lokalen Projektverzeichnis in das Container-Arbeitsverzeichnis (`/app`). Diese Dateien enthalten die Abhängigkeiten für das Projekt, die für den nächsten Schritt benötigt werden.

- **`RUN npm ci --silent`**: Dieser Befehl führt `npm ci` aus, um die Abhängigkeiten des Projekts zu installieren. `npm ci` wird verwendet, um die installierten Pakete basierend auf der `package-lock.json` genau zu installieren und ist schneller und deterministisch als `npm install`. Das `--silent`-Flag unterdrückt unnötige Ausgaben.

- **`COPY . ./`**: Dieser Befehl kopiert alle Dateien und Ordner aus dem aktuellen Verzeichnis (auf dem Host) in das Container-Verzeichnis `/app`. Dabei werden alle Projektdateien, einschließlich des Quellcodes, in den Container übernommen.

- **`RUN npm run build`**: Dieser Befehl führt das Build-Skript aus, das durch `create-react-app` erstellt wurde. In der Regel wird durch diesen Befehl das React-Projekt für die Produktion gebaut. Es erzeugt einen optimierten `build`-Ordner, der die komprimierten HTML-, CSS- und JavaScript-Dateien enthält, die im Produktionsmodus verwendet werden.

### 2. **Produktionsumgebung**

- **`FROM nginx:stable-alpine`**: In diesem Schritt wird das Basis-Image für die Produktionsumgebung festgelegt. Nginx ist ein Webserver, der verwendet wird, um die im Build-Ordner generierten Dateien bereitzustellen. Das `alpine`-Tag stellt sicher, dass auch dieses Image auf einer leichten Version von Linux basiert.

- **`COPY --from=build /app/build /usr/share/nginx/html`**: Dies ist der *Multi-Stage Build* in Aktion. Der Befehl kopiert die fertigen, gebauten Dateien aus dem vorherigen `build`-Schritt in das Nginx-Image. Der Pfad `/app/build` ist der Pfad im `build`-Container (wo die `npm run build`-Ergebnisse liegen), und die Dateien werden in den Nginx-Ordner `/usr/share/nginx/html` kopiert, der der Standardordner für die zu liefernden Web-Inhalte von Nginx ist.

- **`EXPOSE 80`**: Dieser Befehl teilt Docker mit, dass der Container auf Port 80 (Standardport für HTTP) lauscht. Dies bedeutet nicht, dass Docker den Port automatisch freigibt, sondern nur, dass der Container auf diesem Port erwartet wird. Beim Starten des Containers können Sie den Port an den Host weiterleiten.

- **`CMD ["nginx", "-g", "daemon off;"]`**: Der `CMD`-Befehl gibt an, was im Container ausgeführt wird, wenn der Container startet. In diesem Fall wird der Nginx-Webserver mit der Option `-g daemon off;` gestartet, um Nginx im Vordergrund auszuführen. Dies verhindert, dass Nginx als Daemon im Hintergrund läuft, was erforderlich ist, damit der Container aktiv bleibt (da Docker den Container beendet, wenn der Hauptprozess im Container endet).

```bash
docker build -f Dockerfile.prod -t sample:prod .
```

```bash
docker run -it --rm -p 1337:80 sample:prod
```

