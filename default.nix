let
  nixexprsLib = import ../nixexprs-lib/default.nix {
    debugVerbosity = 9;
  };
in nixexprsLib.channel {
  name = "infinisil";

  # Specifies channel dependencies
  # Only the channels listed here are available under self.flox.channels.*
  inputChannels = [ "NixOS" "chan1" "chan2" ];

  # TODO: Should overlays be transitive somehow?
  #nixpkgsOverlays = [];

  # This config is propagated to all dependent channels
  # If this repo is used as the root, these values are used
  # If it's not, the root's values are used
  # But is that really what we want?
  # -> Let the user choose whether they want to set a different nixpkgs version
  #    only for this channel, or also for all dependencies
  # Wait, because of how hydra works, we *have* to use a single version of each
  # channel, can't have different ones

  # How about having an overlay tree?
  # Each transitiveConfigDefaults of each channel is an overlay
  # If there's a channel dependency chain, each channel in the chain adds their own overlay
  # This probably causes inf rec problems for channels having a cyclic dependency -> let's not do that
  # 
  channelConfig = {
    defaultPythonVersion = 2;
    debugVerbosity = 0;
  };

  # Specifies a dependency on the chan1 and chan2 channels
  # This function is called with the resolved
  outputOverlays = [
    # nixexprsLib has functions for auto-calling directories
    (nixexprsLib.auto.python ./pythonPackages)
    (nixexprsLib.auto.perl ./perlPackages)

    # But users can also define packages directly
    (self: super: {
      # To avoid namespace-clashes, all flox attributes are under flox.*
      foo = self.flox.builders.mkDerivation {
        # Sets src to foo's source
        project = "foo";

        # Other channels accessible through flox.channels.*
        buildInputs = [ self.flox.channels.chan1.foolib ];
      };

      # Example of importing a Nix expression from the project source
      #bar = import (self.flox.source "bar" {}) {};

      # Import flox.nix from all given packages
    })
  ];
}
