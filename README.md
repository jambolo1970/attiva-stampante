# 🖨️ Attiva Stampante

**Attiva Stampante** è uno script in Python che consente di riattivare stampanti disabilitate tramite `CUPS` (Common Unix Printing System) in modo semplice e visuale, con supporto per terminali colorati, ambienti desktop KDE, GNOME, Cinnamon, MATE, ecc.

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

---

## 🚀 Installazione

Clona il repository o scarica la cartella, poi esegui:

```bash
make install


## 🔧 Disinstallazione

all'interno della directory attiva-stampante digita

```bash
make uninstall
