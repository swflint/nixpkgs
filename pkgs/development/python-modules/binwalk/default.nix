{ lib, stdenv
, buildPythonPackage
, fetchFromGitHub
, zlib
, xz
, ncompress
, gzip
, bzip2
, gnutar
, p7zip
, cabextract
, cramfsprogs
, cramfsswap
, sasquatch
, squashfsTools
, lzma
, matplotlib
, nose
, pycrypto
, pyqtgraph ? null }:

let
  visualizationSupport = (pyqtgraph != null) && (matplotlib != null);
  version = "2.2.0";
in
buildPythonPackage {
  pname = "binwalk";
  inherit version;

  src = fetchFromGitHub {
    owner = "devttys0";
    repo = "binwalk";
    rev = "be738a52e09b0da2a6e21470e0dbcd5beb42ed1b";
    sha256 = "1bxgj569fzwv6jhcbl864nmlsi9x1k1r20aywjxc8b9b1zgqrlvc";
  };

  propagatedBuildInputs = [ zlib xz ncompress gzip bzip2 gnutar p7zip cabextract cramfsswap cramfsprogs sasquatch squashfsTools lzma pycrypto ]
  ++ stdenv.lib.optionals visualizationSupport [ matplotlib pyqtgraph ];

  # setup.py only installs version.py during install, not test
  postPatch = ''
    echo '__version__ = "${version}"' > src/binwalk/core/version.py
  '';

  # binwalk wants to access ~/.config/binwalk/magic
  preCheck = ''
    HOME=$(mktemp -d)
  '';

  checkInputs = [ nose ];

  meta = with lib; {
    homepage = "https://github.com/ReFirmLabs/binwalk";
    description = "A tool for searching a given binary image for embedded files";
    maintainers = [ maintainers.koral ];
  };
}
