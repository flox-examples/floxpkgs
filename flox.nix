{
  self,
  inputs,
  lib,
  ...
}:

  # re-call yourself with overrides, will not work if using in-memory lockfile
  let hydraOverride = path: follows: (inputs.flox-floxpkgs.capacitor.lib.capacitor.callFlake
    (builtins.readFile (self + "/flake.lock"))
    self "" "" "root" { }
    [ {
        path = path;
        follows = follows;
      } ]
    ).hydraJobs;
  in

# Define package set structure
{

  # Template Configuration:
  # DO NOT EDIT
  config.extraPlugins = [
      (
        inputs.flox-floxpkgs.plugins.catalog {
          catalogDirectory = self.outPath + "/catalog";
        }
      )
      (inputs.flox-floxpkgs.capacitor.plugins.allLocalResources {})
    ];

  passthru."hydraJobsStaging" = hydraOverride ["nixpkgs" "nixpkgs"] ["nixpkgs" "nixpkgs-staging"];
  passthru."hydraJobsUnstable" = hydraOverride ["nixpkgs" "nixpkgs"] ["nixpkgs" "nixpkgs-unstable"];
  passthru."hydraJobsStable" = hydraOverride ["nixpkgs" "nixpkgs"] ["nixpkgs" "nixpkgs-stable"];
}
