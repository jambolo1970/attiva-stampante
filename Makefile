PREFIX ?= /usr/local
BINDIR = $(PREFIX)/bin
USER_HOME = $(shell eval echo ~$(SUDO_USER))
DESKTOPDIR = $(USER_HOME)/.local/share/applications
ICONDIR = $(USER_HOME)/.local/share/icons
DESKTOPFILE = attiva-stampante.desktop
DESKTOP_TEMPLATE = attiva-stampante.desktop.in
DESKTOP_ICON_PATH = $(ICONDIR)/attiva-stampante.png
DESKTOP_LAUNCH_PATH = $(DESKTOPDIR)/$(DESKTOPFILE)
DESKTOP_SHORTCUT = $(USER_HOME)/Scrivania/$(DESKTOPFILE)
SCRIPT_NAME = attiva_stampante.py
LAUNCHER = attiva-stampante-launcher.sh
ICON_NAME = attiva-stampante.png

all: install

install:
	@echo "🔧 Installazione script..."
	install -m 755 $(SCRIPT_NAME) $(BINDIR)/attiva-stampante
	install -m 755 $(LAUNCHER) $(BINDIR)/attiva-stampante-launcher.sh

	@echo "🖼️  Installazione icona..."
	mkdir -p $(ICONDIR)
	install -m 644 $(ICON_NAME) $(DESKTOP_ICON_PATH)

	@echo "🧾 Creazione launcher menu..."
	mkdir -p $(DESKTOPDIR)
	sed "s|{{BIN_PATH}}|$(BINDIR)|g; s|{{ICON_PATH}}|$(ICONDIR)|g" \
		$(DESKTOP_TEMPLATE) > $(DESKTOP_LAUNCH_PATH)
	chmod +x $(DESKTOP_LAUNCH_PATH)

	@echo "📁 Copia sulla scrivania (se esiste)..."
	if [ -d "$(USER_HOME)/Scrivania" ]; then \
		cp $(DESKTOP_LAUNCH_PATH) $(DESKTOP_SHORTCUT); \
		chmod +x $(DESKTOP_SHORTCUT); \
	fi

	@echo "🔄 Aggiornamento menu KDE/GNOME..."
	@which update-desktop-database >/dev/null && update-desktop-database $(DESKTOPDIR) || true
	@which kbuildsycoca5 >/dev/null && kbuildsycoca5 || true

	@echo "✅ Installazione completata! Cerca 'Attiva Stampante' nel menu."

uninstall:
	rm -f $(BINDIR)/attiva-stampante
	rm -f $(BINDIR)/attiva-stampante-launcher.sh
	rm -f $(DESKTOP_LAUNCH_PATH)
	rm -f $(DESKTOP_SHORTCUT)
	rm -f $(DESKTOP_ICON_PATH)
	@echo "🧹 Disinstallazione completata."
