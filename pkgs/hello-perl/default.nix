{ perlPackages, flox }:

flox.perlPackages.buildPerlPackage {
  project = "hello-perl";
  buildInputs = [ perlPackages.ModuleInstall ];
  postBuild = "touch $devdoc";
}
