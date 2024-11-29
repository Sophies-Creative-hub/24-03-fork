### **1. Repository klonen**

```bash
git clone <URL-des-Kurs-Repositories>
```

---

### **2. Ein neues eigenes Repository erstellen**
Erstellen ein neues, leeres Repository in deinem GitHub-Konto:

1. Gehe zu [GitHub](https://github.com) und klicke auf **"New Repository"**.
2. Gib einen Namen für das neue Repository ein (z. B. `mein-kurs-repo`).
3. Lasse das Repository **leer** (ohne README, `.gitignore` oder Lizenz).
4. Kopiere die HTTPS- oder SSH-URL des neuen Repositories.

---

### **3. Die Remote-URL ändern**
Ändere die Remote-URL des geklonten Repositories, um es auf dein neues Repository zu verweisen:

1. Wechsel in das Verzeichnis des geklonten Repositories:
   ```bash
   cd <name-des-repositories>
   ```

2. Entferne die aktuelle Remote-URL (die zum Haupt-Repository zeigt):
   ```bash
   git remote remove origin
   ```

3. Füge das neue Repository als Remote hinzu:
   ```bash
   git remote add origin <URL-des-neuen-Repositories>
   ```

---

### **4. Änderungen pushen**
Jetzt kannst du den gesamten Code in dein eigenes Repository pushen:

1. Pushen Sie alle Branches:
   ```bash
   git push -u origin main
   ```
---

### **Zusammenfassung**
1. Klonen des Kurs-Repositorys:
   ```bash
   git clone <URL-des-Kurs-Repositories>
   ```
2. Neues Repository erstellen und Remote-URL anpassen:
   ```bash
   git remote remove origin
   git remote add origin <URL-des-neuen-Repositories>
   ```
3. Änderungen in das eigene Repository pushen:
   ```bash
   git push -u origin main
   ```

---

### **Hinweis**
- Änderungen, die du lokal machst, sind unabhängig vom Haupt-Repository, nachdem die Remote-URL geändert wurde.
