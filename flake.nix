{
  inputs.nixpkgs.url = "nixpkgs";
  inputs.phase2.url = "path:./.flox";

  outputs = {nixpkgs,...}@_: {
    a = _.phase2;

    dynamicInputs = {
      # Contract.... these inputs must evaluate to simple key-value
      inputs = builtins.listToAttrs (map (v: {
        name = "__vscode_${v.publisher}-${v.extension}";
        value = {
          url = "https://${v.publisher}.gallery.vsassets.io/_apis/public/gallery/publisher/${v.publisher}/extension/${v.extension}/latest/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
          flake = false;
          type = "file";
        };
      }) [
        {publisher="ms-python";extension="pylint";}
      ]);

      # inputs = readDir pkgs {
      #   subflake_${n}= "path:./${path-to-subflake}";
      #   inputs.capacitor.follows = "asdfasf";
      # };
      # inputs = lib.allSubflakes // lib.allVsCodeExtensions // lib.allVersions;

      outputs = ''_: _'';

      # g = import (derivation {
      #   name = "test-impure";
      #   __impure = true;
      #   builder = "/bin/sh";
      #   system = "x86_64-linux";
      #   args = ["-c" ''
      #     echo "'''" >> $out
      #     ${nixpkgs.legacyPackages.x86_64-linux.curl}/bin/curl -k https://example.com >> $out
      #     echo "'''" >> $out
      #     ''];
      # });
    };

  };
}
