# flox version of mkYarnPackage, enhanced to provide all the
# magic required to locate source, version and build number from
# metadata cached by the nixpkgs mechanism.

# Arguments provided to callPackage().
{ mkYarnPackage, lib, meta, ... }:

# Arguments provided to flox.mkDerivation()
{ project # the name of the project, required
, channel ? meta.importingChannel, ... }@args:
let
  source = meta.getChannelSource channel project args;

  # Actually create the derivation.
in mkYarnPackage (removeAttrs args [ "channel" ] // rec {
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
