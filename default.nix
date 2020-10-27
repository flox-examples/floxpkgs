let
  nixexprsLib = import ../nixexprs-lib/default.nix {
    debugVerbosity = 9;
  };
in nixexprsLib.channel {
  name = "infinisil";

  # Specifies channel dependencies
  # Channels listed here are available in outputOverlays under flox.channels.<name>
  inputChannels = [ "other" ];

  # The channel config is propagated down to all dependent channels
  # Also means that other channels depending on this one can override this default
  channelConfig.defaultPythonVersion = 2;

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
        buildInputs = [ self.flox.channels.other.libfoo ];
      };

      # TODO: Allow each project to specify a flox.nix file, which then get made available by default
    })
  ];
}
