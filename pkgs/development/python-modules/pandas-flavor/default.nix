{ buildPythonPackage
, fetchFromGitHub
, lib
, pandas
, xarray
, lazy-loader
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "pandas_flavor";
  version = "0.5.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "pyjanitor-devs";
    repo = "pandas_flavor";
    rev = "refs/tags/v${version}";
    hash = "sha256-DtgtU5WWxUTF7Wunvf/ZdWvsXCjhX/3Kq+oiafCqNhg=";
  };

  propagatedBuildInputs = [
    pandas
    xarray
    lazy-loader
  ];

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "pandas_flavor"
  ];

  meta = with lib;
    {
      description = "The easy way to write your own flavor of Pandas";
      homepage = "https://github.com/pyjanitor-devs/pandas_flavor/";
      changelog = "https://github.com/pyjanitor-devs/pandas_flavor/blob/v${version}/CHANGELOG.md";
      license = licenses.mit;
      maintainers = with maintainers; [ swflint ];
    };
}
