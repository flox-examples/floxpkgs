{ perlPackages }:

perlPackages.buildPerlPackage {
  project = "hello-perl";
  buildInputs = [ perlPackages.ModuleInstall ];
  postBuild = "touch $devdoc";
}
