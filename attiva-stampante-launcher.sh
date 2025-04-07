#!/bin/bash
# Script compatibile con vari desktop per aprire lo script nel terminale
if command -v gnome-terminal >/dev/null 2>&1; then
    gnome-terminal -- bash -c "attiva-stampante; exec bash"
elif command -v konsole >/dev/null 2>&1; then
    konsole -e attiva-stampante
elif command -v xterm >/dev/null 2>&1; then
    xterm -e attiva-stampante
elif command -v mate-terminal >/dev/null 2>&1; then
    mate-terminal -e attiva-stampante
else
    echo "Terminale non supportato. Avvia 'attiva-stampante' da terminale."
fi

