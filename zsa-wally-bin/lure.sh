#!/bin/zsh
# vim: ft=sh
name="zsa-wally-bin"
version="2.1.3"
_dir_name="wally-$version-linux"
release=1
desc="Flash your ZSA Keyboard the EZ way"
homepage="https://github.com/zsa/wally"
architectures=("amd64")
license=("MIT")
provides=("zsa-wally=$version")

deps_fedora=("gtk3" "webkit2gtk3" "libusb")

sources_amd64=(
    "https://configure.ergodox-ez.com/wally/linux?~name=wally"
    "https://github.com/zsa/wally/archive/refs/tags/${version}-linux.tar.gz"
)
checksums_amd64=(
    "a30c974c2fd544975e48f7f2ac99a21f936fa3e0803afeeb1096826a79afdbde"
    "6d0681a422055208bcfbcb20f44503df05e9e8cf66ba2ef7adec6e5fb8e634ee"
)

package() {
    ls "$srcdir"
    install -Dm 755 "$srcdir/wally" "$pkgdir/usr/bin/wally"
    install -Dm 644 "$srcdir/$_dir_name/dist/linux64/"*.rules -t "$pkgdir/usr/lib/udev/rules.d/"
    install -Dm 644 "$srcdir/$_dir_name/dist/linux64/"*.desktop -t "$pkgdir/usr/share/applications/"
    install -Dm 644 "$srcdir/$_dir_name/appicon.png" "$pkgdir/usr/share/pixmaps/wally.png"
    install -Dm 644 "$srcdir/$_dir_name/license.md" "$pkgdir/usr/share/licenses/$pkgname/license.md"
}
