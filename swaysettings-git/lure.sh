#!/bin/zsh
# vim: ft=sh
name="swaysettings-git"
_pkgname=swaysettings
_ver="0.5.0"
version="$_ver-r219.501052e"
release=1
desc="A gui for setting sway wallpaper, default apps, GTK themes, etc..."
homepage="https://github.com/ErikReider/swaysettings"
architectures=("amd64")
license=("GPL3")
provides=("swaysettings=$_ver")
conflicts=("swaysettings")

build_deps=("git" "meson" "scdoc" "vala" "blueprint-compiler")
build_deps_fedora=("git" "meson" "vala" "gtk4-layer-shell-devel" "libadwaita-devel" "gtk4-devel" "glib2-devel" "libgee-devel" "gobject-introspection-devel" "json-glib-devel" "granite-7-devel" "libxml2-devel" "accountsservice-devel" "pulseaudio-libs-devel" "libudisks2-devel" "libgtop2-devel")

deps=("gtk4" "gtk4-layer-shell" "libadwaita" "glib2" "gobject-introspection" "libgee" "json-glib" "granite-7" "libxml2" "xkeyboard-config" "accountsservice" "gtk4-layer-shell" "libpulse" "bluez" "udisks2" "libgtop2")
deps_fedora=("accountsservice" "gtk4-layer-shell" "bluez" "pulseaudio-libs" "gtk4" "glib2" "udisks2" "libgtop2")

sources=("git+https://github.com/ErikReider/swaysettings.git?~rev=main")
checksums=("SKIP")

version() {
    cd "$srcdir/$_pkgname"
    printf "$_ver-r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

build() {
    cd "$srcdir/$_pkgname"
    meson setup --prefix /usr build
    meson compile -C build
}

package() {
    cd "$srcdir/$_pkgname"
    DESTDIR="$pkgdir" meson install -C build
}
