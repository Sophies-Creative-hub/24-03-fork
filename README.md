## **Anleitung zur Nutzung des Kurs-Repositorys (Fork-Methode)**

Mit dieser Methode erstellt jeder Teilnehmer eine eigene Kopie des Kurs-Repositorys in seinem GitHub-Konto. Dadurch können alle unabhängig arbeiten, ohne das Haupt-Repository zu beeinflussen.

---

### **1. Repository forken**
1. Öffne das Kurs-Repository auf GitHub:
   - [Link zum Kurs-Repository] (ersetze mit deinem tatsächlichen Link).
2. Klicke oben rechts auf **"Fork"**.
3. Wähle dein eigenes GitHub-Konto als Ziel für den Fork.
4. Nach wenigen Sekunden erscheint eine Kopie des Repositories in deinem GitHub-Konto, z. B.:
   - `https://github.com/dein-benutzername/kurs-repo`.

---

### **2. Fork klonen**
1. Kopiere die URL deines geforkten Repositories (HTTPS oder SSH).
2. Öffne ein Terminal und klone das geforkte Repository:
   ```bash
   git clone <URL-deines-Forks>
   ```
   Beispiel:
   ```bash
   git clone https://github.com/dein-benutzername/kurs-repo.git
   ```
3. Wechsle in das Verzeichnis des geklonten Repositories:
   ```bash
   cd kurs-repo
   ```

---

### **3. Remote-URL für `upstream` konfigurieren**
Um sicherzustellen, dass du Änderungen aus dem Original-Repository abrufen kannst, musst du das Haupt-Repository als `upstream` remote hinzufügen.

1. **Überprüfen, welche Remotes konfiguriert sind:**
   Um zu sehen, welche Remotes aktuell eingerichtet sind, führe den folgenden Befehl aus:
   ```bash
   git remote -v
   ```

2. **Falls die `upstream`-URL falsch ist, korrigiere sie:**
   Wenn du siehst, dass die `upstream`-URL auf einen Ordner verweist (z. B. `https://github.com/Sophie-Techstarter/24-03/tree/main/Docker/29_11_2024`), musst du sie auf die **gesamte Repository-URL** ändern:
   ```bash
   git remote set-url upstream https://github.com/Sophie-Techstarter/24-03.git
   ```

3. **Überprüfe, ob die URL nun korrekt ist:**
   Führe den folgenden Befehl aus, um sicherzustellen, dass die URL von `upstream` jetzt korrekt gesetzt ist:
   ```bash
   git remote -v
   ```
   Die Ausgabe sollte nun wie folgt aussehen:
   ```plaintext
   origin    git@github.com:dein-benutzername/24-03-fork.git (fetch)
   origin    git@github.com:dein-benutzername/24-03-fork.git (push)
   upstream  https://github.com/Sophie-Techstarter/24-03.git (fetch)
   upstream  https://github.com/Sophie-Techstarter/24-03.git (push)
   ```

---

### **4. Mit dem Repository arbeiten**
1. Erstelle einen neuen Branch für deine Änderungen (optional, aber empfohlen):
   ```bash
   git checkout -b mein-branch
   ```
2. Führe deine Änderungen im Code durch.
3. Füge die Änderungen zur Versionskontrolle hinzu:
   ```bash
   git add .
   ```
4. Committe deine Änderungen:
   ```bash
   git commit -m "Beschreibung der Änderungen"
   ```
5. Push die Änderungen in dein Fork-Repository:
   ```bash
   git push origin mein-branch
   ```

---

### **5. Änderungen vom Haupt-Repository synchronisieren**
Falls das Kurs-Repository aktualisiert wird, kannst du die neuesten Änderungen in dein eigenes Repository übernehmen.

1. **Holen der neuesten Änderungen vom `upstream`:**
   ```bash
   git fetch upstream
   ```

2. **Mischen der Änderungen in deinen Branch:**
   - Falls du im Branch `main` arbeitest:
     ```bash
     git merge upstream/main
     ```
     oder (für eine saubere, lineare Historie):
     ```bash
     git rebase upstream/main
     ```

3. **Pushen der Änderungen in dein eigenes Repository:**
   ```bash
   git push origin main
   ```

---

### **Zusammenfassung**
- **Forken**: Erstellt eine persönliche Kopie des Kurs-Repositorys in deinem GitHub-Konto.
- **Klonen**: Arbeite lokal mit deinem Fork.
- **Remote für `upstream` hinzufügen**: Damit du Änderungen aus dem Haupt-Repository abrufen kannst, füge das Haupt-Repository als `upstream` hinzu.
- **Änderungen synchronisieren**: Halte deinen Fork mit dem Kurs-Repository aktuell.
- **Vorteil**: Du arbeitest unabhängig, ohne das Haupt-Repository zu beeinflussen. Wenn das Haupt-Repository aktualisiert wird, kannst du diese Änderungen in deinen Fork integrieren.

