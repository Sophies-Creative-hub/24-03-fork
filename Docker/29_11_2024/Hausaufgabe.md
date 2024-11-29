# Hausaufgabe

Gebe Screenshots für die Stellen ab, an denen **Abgabe** steht.

---

### Aufgabe 1: Wiederholung

#### 1. Nach einem Image suchen

- Suche über den Befehl `docker search` nach dem Image von `nginx`.
- Ziehe dir nun das offizielle Image.

Starte drei Container dieses Images.

Stelle sicher, dass alle drei Container laufen und lass dir dies anzeigen.

**Abgabe**: Screenshot des Terminals mit den drei laufenden Containern.

Stoppe nun die drei Container und lösche sie.
Lösche ebenfalls das Image.
Gehe sicher, dass alles gelöscht ist.

**Abgabe**: Screenshot des Terminals, das zeigt, dass keine Container laufen.

---

### Aufgabe 2: Docker-Images vergleichen

#### Schritt 1: Docker-Images herunterladen

- Ziehe zwei verschiedene Docker-Images: eines mit Ubuntu und eines mit Alpine Linux.

Die beiden Images heißen:  
- `devopsdockeruh/simple-web-service:ubuntu`  
- `devopsdockeruh/simple-web-service:alpine`  

Die beiden Images enthalten eine einfache Webanwendung, die eine Willkommensnachricht ausgibt.

**Abgabe**: Screenshot des Terminals nach dem Ziehen der Docker-Images.

#### Schritt 2: Größen vergleichen

- Vergleiche die Größen der beiden Images.

**Abgabe**: Screenshot des Terminals, auf dem man die Größe der beiden Images sieht.



### Aufgabe 3: Eine einfache Web-App mit Docker betreiben

### Ziel:
Erstellen und betreiben einer einfachen Node.js-Web-App in Docker.

### Schritte:

**1.1. Erstelle die Node.js-Web-App:**

1. Erstelle ein Verzeichnis:
2. Erstelle die Datei `app.js`:
   ```javascript
   const http = require('express');
   const port = 3000;

   app.get('/', (req, res) => {
      res.send('Hello World!');
   });

   app.listen(port, () => {
      console.log(`App listening at <http://localhost>:${port}`);
   });
   ```

3. Erstelle die Datei `package.json`:

**1.2. Erstelle das Dockerfile:**

**1.3. Erstelle und starte das Docker-Image:**

1. Erstelle das Docker-Image:
2. Starte den Container:
3. Gehe zu `http://localhost:3000` im Browser, um die Web-App zu sehen.

**Abgabe**: Screenshot der laufenden App im Browser. 

---

## Aufgabe 4: Code ausprobieren und beschreiben

Schaut euch den Code im Ordner `zweites_image` an. Probiert ihn aus, indem ihr ein Image aus der Dockerfile erstellt und beschreibt, was in der Dockerfile passiert.
