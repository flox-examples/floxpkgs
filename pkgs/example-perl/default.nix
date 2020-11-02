{ channels, perlPackages }:

channels.flox.buildPerlPackage {
  project = "example-perl";
  buildInputs = [ perlPackages.ModuleInstall ];
  postBuild = "touch $devdoc";
}
