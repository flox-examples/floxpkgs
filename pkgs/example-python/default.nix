{ pythonPackages, channels }:

channels.flox.buildPythonApplication {
  project = "example-python";
}
