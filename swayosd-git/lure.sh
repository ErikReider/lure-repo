#!/bin/zsh
# vim: ft=sh
_pkgname="SwayOSD"
_pkgname_lower="swayosd"
name="$_pkgname_lower-git"
_ver="0.1.0"
version="$_ver-r26.377496a"
release=2
desc="A GTK based on screen display for keyboard shortcuts like caps-lock and volume"
homepage="https://github.com/ErikReider/$_pkgname"
architectures=("amd64")
license=("GPL3")
provides=("$_pkgname_lower=$_ver")
conflicts=("$_pkgname_lower")

build_deps_fedora=("git" "meson" "gtk-layer-shell-devel" "pulseaudio-libs-devel" "glib2-devel" "gtk3-devel" "polkit-devel" "libinput-devel" "libevdev-devel" "sassc")

# Add cargo as dependency if rustup isn't used as the rust package provider
if ! command -v rustup &>/dev/null; then
    build_deps_fedora+=("cargo")
fi

deps_fedora=("gtk-layer-shell" "pulseaudio-libs" "gtk3" "glib2")

sources=("git+https://github.com/ErikReider/$_pkgname.git")
checksums=("SKIP")

version() {
    cd "$srcdir/$_pkgname"
    printf "$_ver-r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

build() {
    cd "$srcdir/$_pkgname"
    meson setup --buildtype release --prefix /usr build
    meson compile -C build
}

package() {
    cd "$srcdir/$_pkgname"
    DESTDIR="$pkgdir" meson install -C build
}
