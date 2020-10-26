let
  nixexprsLib = import <nixexprs-lib> {};
in nixexprsLib.channel {
  # The name of this channel, so it's available at eval time
  name = "infinisil";

  # Allows specifying nixpkgs overlays
  nixpkgsOverlays = [
    # Override ncurses of all nixpkgs derivations to use our own
    (self: super: {
      # flox.self points to our own channel
      ncurses = super.flox.self.ncurses;
    })
  ];

  # Specifies channel dependencies
  inputChannels = [ "chan1" "chan2" ];

  # Specifies a dependency on the chan1 and chan2 channels
  # This function is called with the resolved
  outputsOverlays = [
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
      bar = import (self.flox.source "bar" {}) {};
    })
  ];
}
