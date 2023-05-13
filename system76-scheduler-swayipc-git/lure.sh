#!/bin/zsh
# vim: ft=sh
_pkgname="system76-scheduler-swayipc"
name="$_pkgname-git"
_ver="0.1.0"
version="$_ver-r3.980d4e6"
release=1
desc="Uses SwayIPC to set the foreground process for the System76 Scheduler"
homepage="https://github.com/ErikReider/$_pkgname"
architectures=("amd64")
license=("GPL3")
provides=("$_pkgname=$_ver")
conflicts=("$_pkgname")

build_deps=("git")

if ! command -v cargo &>/dev/null; then
    build_deps+=("cargo" "rust")
    echo "Cargo not found, adding as a build dependency"
fi

deps=("sway")

sources=("git+https://github.com/ErikReider/$_pkgname.git")
checksums=("SKIP")

version() {
    cd "$srcdir/$_pkgname"
    printf "$_ver-r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

build() {
    cd "$srcdir/$_pkgname"
    cargo build --release
}

package() {
    cd "$srcdir/$_pkgname"
    install -Dm755 "target/release/$_pkgname" "$pkgdir/usr/bin/$_pkgname"
}
