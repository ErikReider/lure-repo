#!/bin/zsh
# vim: ft=sh
name="swaync-git"
_pkgname=SwayNotificationCenter
_ver="v0.9.0"
version="$_ver.r448.ba4a266"
release=2
desc="A simple notificaion daemon with a GTK panel for checking previous notifications like other DEs"
homepage="https://github.com/ErikReider/SwayNotificationCenter"
architectures=(
    'amd64'
    'aarch64' # ARM v8 64-bit
    'armv7h'  # ARM v7 hardfloat
)
license=("GPL3")
provides=("swaync=$_ver")
conflicts=("swaync" "SwayNotificationCenter")

build_deps=("git" "meson" "scdoc" "vala")
build_deps_fedora=("git" "meson" "vala" "gtk-layer-shell-devel" "libhandy-devel" "gtk3-devel" "glib2-devel" "libgee-devel" "gobject-introspection-devel" "json-glib-devel" "pulseaudio-libs-devel")

deps=("gtk3" "gtk-layer-shell" "dbus" "glib2" "gobject-introspection" "libgee" "json-glib" "libhandy" "libpulse")
deps_fedora=("gtk-layer-shell" "pulseaudio-libs" "gtk3" "glib2")

sources=("git+https://github.com/ErikReider/SwayNotificationCenter.git")
checksums=("SKIP")

version() {
    cd "$srcdir/$_pkgname"
    (
        set -o pipefail
        git describe --long 2>/dev/null | sed 's/\([^-]*-g\)/r\1/;s/-/./g' \
            || printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
    )
}

build() {
    cd "$srcdir"
    meson setup --prefix /usr "$_pkgname" build -Dscripting=true
    meson compile -C build
}

package() {
    cd "$srcdir"
    DESTDIR="$pkgdir" meson install -C build
    install -Dm644 "$_pkgname/COPYING" -t "$pkgdir/usr/share/licenses/$pkgname"
    install -Dm644 "$_pkgname/README.md" -t "$pkgdir/usr/share/doc/$pkgname"
}
