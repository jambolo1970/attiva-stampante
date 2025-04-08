# 🖨️ Attiva Stampante

**Attiva Stampante** è uno script in Python che consente di riattivare stampanti disabilitate, in caso di spegnimento durante la stampa infatti a volte vengono messe in pausa, tramite `CUPS` (Common Unix Printing System) in modo semplice e visuale, il programma è scritto in Python ed apre una finestra a cui di dovrà dare la password di root per poter abilitare la stampante in pausa, il tutto all'interno di una finestra terminale che si chiuderà automaticamente al termine dell'operazione, ambienti desktop KDE, GNOME, Cinnamon, MATE, ecc. dovrebbero essere compatibili.

Si può lanciare lo stesso programma semplicemente aprendo una finestra terminale e digitanto 
```attiva-stampante``` poi premere invio


---

## ✨ Funzionalità

- ✅ Mostra l'elenco delle stampanti installate
- 🎨 Evidenzia con colore lo stato: attiva, inattiva, disabilitata
- 🧩 Compatibile con sistemi localizzati in italiano o inglese
- 🧾 Installa una voce nel menu con icona e lancio da terminale
- 💡 Supporta vari terminali: `gnome-terminal`, `konsole`, `xterm`, `mate-terminal`

---

## 📦 Requisiti

- Linux con `CUPS` installato (es: OpenSUSE, Linux Mint, Ubuntu)
- Python 3.x
- Privilegi `sudo` per accedere a `lpstat` e `cupsenable`
- Terminale compatibile per esecuzione interattiva
- notify-send (libnotify-bin o libnotify-tools)

---

## 🚀 Installazione

Clona il repository o scarica la cartella, poi esegui all'interno della stessa cartella scompattata:

```bash
sudo make install
```

## 🔧 Disinstallazione

all'interno della directory attiva-stampante digita

```bash
sudo make uninstall
```
