title: Übung Github

# Notwendige Vorbereitungen
1. Anlegen eines Benutzeraccounts auf [GitHub](http://github.com)
2. Installation von [VS Code](https://code.visualstudio.com/)
3. Installation von [Git (for Windows)](https://gitforwindows.org/) mit `PATH` Variable (Option 2 oder 3)!

![Git Installation](git_installer.png)

# Proxy Konfiguration
Für die HTL Rankweil ist eine zusätzliche Proxy Konfiguration notwendig. Bitte folgendes in einem Terminal (`cmd`) ausführen:

```bash
git config --global http.proxy http://proxy.htl.rankweil:8080/
```

Um den Proxy wieder zu entfernen:

```
git config --global --unset http.proxy
```

# Inhalt
1. Anlegen eines Projektes
2. Anlegen von Dateien online
3. "Clonen" des Projekts mit VSCode
4. Lokales Ändern, *commiten* und *pushen*
5. Anlegen eines Issues
6. Kommentieren eines Issues im Projekt des Sitznachbars
7. Forken des Projekts vom Sitznachbar, Ändern und senden eines Pull Requests
