{ flox, pythonPackages }:
flox.pythonPackages.buildPythonApplication {
  project = "hello-python";
  propagatedBuildInputs = [ 
    pythonPackages.hello-python-library
  ];
}
