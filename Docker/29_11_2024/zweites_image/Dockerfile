# Verwenden von Alpine-Image, da es klein und einfach ist
FROM alpine:3.19

# Arbeitsverzeichnis setzen
WORKDIR /app

# Kopiere das hello.sh-Skript ins Arbeitsverzeichnis
COPY hello.sh . 

# Dem Skript Ausführungsrechte geben 
RUN chmod +x hello.sh

# Wenn der Container läuft, führe hello.sh aus
CMD ./hello.sh
