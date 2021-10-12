{ buildPythonPackage, appdirs }:
buildPythonPackage {
  project = "hello-python-library";
  propagatedBuildInputs = [ appdirs ];
}
