{ flox, appdirs }:
flox.pythonPackages.buildPythonPackage {
  project = "hello-python-library";
  propagatedBuildInputs = [ appdirs ];
}
