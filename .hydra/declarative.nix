{pkgs ? (builtins.getFlake "nixpkgs").legacyPackages.x86_64-linux, ...}: let
  mkFlakeJobset = branch: stability: {
    description = "Packages built with nixpkgs ${pkgs.lib.toLower stability}";
    checkinterval = "6000";
    enabled = "1";
    schedulingshares = 10;
    enableemail = false;
    emailoverride = "";
    keepnr = 1;
    hidden = false;
    type = 1;
    flake = "github:flox-examples/floxpkgs/${branch}";
    flakeattr = "hydraJobs${stability}";
  };

  desc = {
    "stable" = mkFlakeJobset "master" "Stable";
    "staging" = mkFlakeJobset "master" "Staging";
    "unstable" = mkFlakeJobset "master" "Unstable";
  };

  log = {
    jobsets = desc;
  };
in {
  jobsets = pkgs.runCommand "spec-jobsets.json" {} ''
    cat >$out <<EOF
    ${builtins.toJSON desc}
    EOF
    # This is to get nice .jobsets build logs on Hydra
    cat >tmp <<EOF
    ${builtins.toJSON log}
    EOF
    ${pkgs.jq}/bin/jq . tmp
  '';
}
