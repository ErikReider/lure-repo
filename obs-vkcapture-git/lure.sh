#!/bin/zsh
# vim: ft=sh
_pkgname=obs-vkcapture
name="$_pkgname-git"
_ver="1.4.1"
version="r46.0645e74"
release=1
desc="OBS Linux Vulkan/OpenGL game capture"
homepage="https://github.com/nowrep/obs-vkcapture"
architectures=("amd64")
license=("GPL2")
provides=("$_pkgname-git" "lib32-$_pkgname-git")
conflicts=("$_pkgname-git" "lib32-$_pkgname-git")

build_deps_fedora=("vulkan-loader-devel" "cmake" "make" "gcc" "obs-studio-devel" "mesa-libGL-devel" "mesa-libEGL-devel" "wayland-devel" "libwayland-client")

deps_fedora=("vulkan-loader")

sources=("git+$homepage.git")
checksums=("SKIP")

version() {
    cd "$srcdir/$_pkgname"
    printf "$_ver-r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

build() {
    cd "$srcdir/$_pkgname"

    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr ..
    make
}

package() {
    cd "$srcdir/$_pkgname"
    make -C build DESTDIR="${pkgdir}/" install
}
