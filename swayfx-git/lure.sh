#!/bin/zsh
# vim: ft=sh
name="swayfx-git"
_pkgname=swayfx
_ver="0.2"
_sway_ver="1.8.1"
version="$_ver-r6951.ac31a612"
release=1
desc="i3-compatible window manager for Wayland"
homepage="https://github.com/WillPower3309/swayfx"
architectures=("amd64")
license=("MIT")
provides=("sway=$_sway_ver" "swayfx=$_ver")
conflicts=("sway" "swayfx")

build_deps=("git" "meson" "scdoc" "wayland-protocols")
build_deps_fedora=("git" "meson" "scdoc" "wayland-protocols-devel" "cairo-devel" "gdk-pixbuf2-devel" "json-c-devel" "pango-devel" "polkit-devel" "pcre2-devel" "wlroots-devel >= 0.16.0" "xorg-x11-server-Xwayland-devel" "libevdev-devel")

deps=("cairo" "gdk-pixbuf2" "json-c" "pango" "polkit" "pcre2" "swaybg" "ttf-font" "wlroots >= 0.16.0" "xorg-server-xwayland")
deps_fedora=("swaybg")

sources=("git+https://github.com/WillPower3309/swayfx.git")
checksums=("SKIP")

version() {
    cd "$srcdir/$_pkgname"
    printf "$_ver-r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

build() {
    meson \
        --prefix /usr \
        -Dsd-bus-provider=libsystemd \
        -Dwerror=false \
        "$_pkgname" build
    meson compile -C build
}

package() {
    install -Dm644 50-systemd-user.conf -t "$pkgdir/etc/sway/config.d/"

    DESTDIR="$pkgdir" meson install -C build

    cd "$_pkgname"
    install -Dm644 "LICENSE" "$pkgdir/usr/share/licenses/$_pkgname/LICENSE"
    for util in autoname-workspaces.py inactive-windows-transparency.py grimshot; do
        install -Dm755 "contrib/$util" -t "$pkgdir/usr/share/$_pkgname/scripts"
    done
}
