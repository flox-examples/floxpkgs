{ perlPackages, flox }:

flox.perlPackages.buildPerlPackage {
  project = "example-perl";
  buildInputs = [ perlPackages.ModuleInstall ];
  postBuild = "touch $devdoc";
}
