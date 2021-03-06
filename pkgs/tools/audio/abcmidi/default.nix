{ lib, stdenv, fetchzip }:

stdenv.mkDerivation rec {
  pname = "abcMIDI";
  version = "2020.12.10";

  src = fetchzip {
    url = "https://ifdo.ca/~seymour/runabc/${pname}-${version}.zip";
    sha256 = "0r9jwjwmdyyfq882mq7gkc2hjrv4ljnidxzlyycjipzndb1gv1ls";
  };

  # There is also a file called "makefile" which seems to be preferred by the standard build phase
  makefile = "Makefile";

  meta = with lib; {
    homepage = "http://abc.sourceforge.net/abcMIDI/";
    downloadPage = "https://ifdo.ca/~seymour/runabc/top.html";
    license = licenses.gpl2Plus;
    description = "Utilities for converting between abc and MIDI";
    platforms = platforms.unix;
    maintainers = [ maintainers.dotlambda ];
  };
}
