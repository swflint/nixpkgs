{ buildPythonPackage
, fetchFromGitHub
, lib
, requests
, littleutils
, setuptools
, setuptools-scm
, git
}:

buildPythonPackage rec {
  pname = "outdated";
  version = "0.2.2";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "alexmojaki";
    repo = "outdated";
    rev = "refs/tags/v${version}";
    hash = "sha256-9mdyH+JEC6juCCFIcRasCgvIwN9+saOw42OTrzh/XTo=";
    leaveDotGit = true;
  };

  nativeBuildInputs = [
    setuptools-scm
    git
  ];

  propagatedBuildInputs = [
    requests
    littleutils
    setuptools
  ];

  pythonImportsCheck = [
    "outdated"
  ];

  meta = with lib; {
    description = "Check if a version of a PyPI package is outdated";
    homepage = "https://github.com/alexmojaki/outdated";
    changelog = "https://github.com/alexmojaki/outdated/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ swflint ];
  };
}
