{ meta, mkYarnPackage }:

let
  project = "simple-site";
  inherit (meta.getSource project { }) version src name;

in
mkYarnPackage {
  inherit version src name;
  packageJSON = "${src}/package.json";
  yarnNix = "${src}/yarndeps.nix";
}
