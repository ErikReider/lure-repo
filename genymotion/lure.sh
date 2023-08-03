#!/bin/zsh
# vim: ft=sh
name="genymotion"
version="3.5.0"
_pkgFolderName="genymotion"
_ARCH="x64"
release=1
desc="Complete set of tools that provides a virtual environment for Android."
homepage="http://www.genymotion.com/"
architectures=("amd64")
license=('custom')
provides=("genymotion")
conflicts=("$name")
sources=(
    "https://dl.genymotion.com/releases/genymotion-$version/$name-$version-linux_$_ARCH.bin"
)
checksums=(
    'ad9c937559f49a734bac63de85a87adbf02f4e0529344b739fe0e2d4edc6dd28'
)

makedepends=("wget")

depends=("VirtualBox" "qt5-websockets" "openssl-1.1" "qt5-svg" "ffmpeg4.4" "qt5-multimedia" "gtk3" "qt5-quickcontrols2" "qt5-location")

package() {
    cd $srcdir

    install -d "$pkgdir/opt"
    install -d "$pkgdir/opt/$name"

    src="$name-$version-linux_$_ARCH.bin"

    # Retrieve line number where tar.bzip2 binary begins
    skip=$(awk '/^__TARFILE_FOLLOWS__/ { print NR + 1; exit 0; }' "$src")
    [ $? -ne 0 ] && return 1

    # Untar following archive
    tail -n +$skip "$src" \
      | tar -xj --no-same-owner -C "$pkgdir/opt/$name"
    [ ${PIPESTATUS[0]} -ne 0 -o ${PIPESTATUS[1]} -ne 0 ] && return 1

    install -d "$pkgdir/usr/bin"
    ln -s "/opt/$name/genymotion" "$pkgdir/usr/bin/genymotion"
    ln -s "/opt/$name/genymotion-shell" "$pkgdir/usr/bin/genymotion-shell"
    ln -s "/opt/$name/player" "$pkgdir/usr/bin/genymotion-player"
    ln -s "/opt/$name/gmtool" "$pkgdir/usr/bin/gmtool"
    install -Dm644 "$scriptdir/genymotion.desktop" "$pkgdir/usr/share/applications/genymotion.desktop"
}
