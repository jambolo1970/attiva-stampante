#!/usr/bin/env python3
import subprocess
import getpass
import sys

COLOR_RESET = "\033[0m"
COLOR_GREEN = "\033[92m"
COLOR_YELLOW = "\033[93m"
COLOR_RED = "\033[91m"

def parse_printer_names(lpstat_output):
    printers = []
    for line in lpstat_output:
        line = line.lower()
        if line.startswith("printer"):
            parts = line.split()
            if len(parts) >= 2:
                printers.append(parts[1])
        elif "la stampante" in line:
            parts = line.split()
            if len(parts) >= 3:
                printers.append(parts[2])
    return printers

def get_printer_status_list(password):
    try:
        result = subprocess.run(
            ['sudo', '-S', 'lpstat', '-p'],
            input=password + '\n',
            universal_newlines=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )

        if result.stderr and "password" not in result.stderr.lower():
            print("Errore:", result.stderr)
            sys.exit(1)

        lines = result.stdout.strip().splitlines()
        printers = []

        for line in lines:
            lower_line = line.lower()
            if "la stampante" in lower_line or "printer" in lower_line:
                parts = line.split()
                name = None
                status = "sconosciuto"

                if lower_line.startswith("printer") and len(parts) >= 2:
                    name = parts[1]
                elif "la stampante" in lower_line and len(parts) >= 3:
                    name = parts[2]

                if "disabled" in lower_line or "disabilitata" in lower_line:
                    status = "disabilitata"
                elif "idle" in lower_line or "inattiva" in lower_line:
                    status = "inattiva"
                elif "enabled" in lower_line or "abilitata" in lower_line:
                    status = "attiva"

                if name:
                    printers.append((name, status))

        return printers

    except Exception as e:
        print("Errore:", e)
        sys.exit(1)

def color_for_status(status):
    if status == "attiva":
        return COLOR_GREEN
    elif status == "inattiva":
        return COLOR_YELLOW
    elif status == "disabilitata":
        return COLOR_RED
    else:
        return COLOR_RESET

def enable_printer(printer_name, password):
    try:
        result = subprocess.run(
            ['sudo', '-S', 'cupsenable', printer_name],
            input=password + '\n',
            universal_newlines=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        if result.returncode == 0:
            print(f"{COLOR_GREEN}La stampante '{printer_name}' è stata riattivata con successo.{COLOR_RESET}")
        else:
            print(f"{COLOR_RED}Errore nella riattivazione della stampante: {result.stderr}{COLOR_RESET}")
    except Exception as e:
        print("Errore:", e)

def main():
    print("=== \033[1mGestione Stampanti (OpenSUSE / Linux Mint)\033[0m ===")
    password = getpass.getpass("Inserisci la password di root (sudo): ")

    printers = get_printer_status_list(password)

    if not printers:
        print("Nessuna stampante trovata.")
        return

    print("\nStampanti disponibili:")
    for idx, (name, status) in enumerate(printers):
        color = color_for_status(status)
        print(f"{idx + 1}. {name} - {color}{status.upper()}{COLOR_RESET}")

    choice = input("\nSeleziona il numero della stampante da riattivare: ")
    try:
        selected = printers[int(choice) - 1][0]
        enable_printer(selected, password)
    except (IndexError, ValueError):
        print(f"{COLOR_RED}Scelta non valida.{COLOR_RESET}")

if __name__ == '__main__':
    main()
