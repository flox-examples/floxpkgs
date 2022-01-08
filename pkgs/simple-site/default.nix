{ mkYarnPackage-evil }:

let
  mkYarnPackage = mkYarnPackage-evil;

in
mkYarnPackage {
  project = "simple-site";
}
