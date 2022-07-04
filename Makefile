FB=flatpak-builder
build: com.upwork.DesktopApp.yaml
	$(FB) --install-deps-from=flathub --force-clean -v build com.upwork.DesktopApp.yaml
	$(FB) --force-clean -v --repo=repo repo-build com.upwork.DesktopApp.yaml

install: build
	sudo $(FB) --install --force-clean build com.upwork.DesktopApp.yaml

clean:
	sudo rm -fr build
	sudo rm -fr repo
	sudo rm -fr repo-build
	sudo rm -fr .flatpak-builder/builds

clean-all: clean
	rm -fr .flatpak-builder

run: build
	flatpak-builder --run --log-session-bus --log-system-bus build/ com.upwork.DesktopApp.yaml /app/upwork

run-installed: install
	flatpak run --log-session-bus --log-system-bus com.upwork.DesktopApp

debug-shell: build
	flatpak-builder --run build/ com.upwork.DesktopApp.yaml sh

uninstall:
	flatpak remove -y com.upwork.DesktopApp

get-sum:
	curl -sL $(url) | sha512sum

all: clean-all build install
