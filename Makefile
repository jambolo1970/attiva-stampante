PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
DESKTOPDIR = ~/.local/share/applications
ICONDIR = ~/.local/share/icons
SCRIPT_NAME = attiva_stampante.py
LAUNCHER = attiva-stampante-launcher.sh
ICON_NAME = attiva-stampante.png
DESKTOP_TEMPLATE = attiva-stampante.desktop.in
DESKTOP_FILE = attiva-stampante.desktop

all: install

install:
	@echo "🔧 Installazione script..."
	install -m 755 $(SCRIPT_NAME) $(BINDIR)/attiva-stampante
	install -m 755 $(LAUNCHER) $(BINDIR)/attiva-stampante-launcher.sh

	@echo "🖼️  Copia icona..."
	install -m 644 $(ICON_NAME) $(ICONDIR)/$(ICON_NAME)

	@echo "🧾 Creazione file .desktop..."
	mkdir -p $(DESKTOPDIR)
	sed "s|{{BIN_PATH}}|$(BINDIR)|g; s|{{ICON_PATH}}|$(ICONDIR)|g" \
		$(DESKTOP_TEMPLATE) > $(DESKTOPDIR)/attiva-stampante.desktop
	chmod +x $(DESKTOPDIR)/attiva-stampante.desktop
	@update-desktop-database $(DESKTOPDIR) || true

	@echo "✅ Installazione completata! Trova 'Attiva Stampante' nel menu."

uninstall:
	rm -f $(BINDIR)/attiva-stampante
	rm -f $(BINDIR)/attiva-stampante-launcher.sh
	rm -f $(DESKTOPDIR)/attiva-stampante.desktop
	rm -f $(ICONDIR)/$(ICON_NAME)
	@echo "🧹 Disinstallazione completata."
