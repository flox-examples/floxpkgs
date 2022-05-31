{
  inputs.floxpkgs.url = "git+ssh://git@github.com/flox/floxpkgs";
  inputs.lock.url = "git+file:./.?ref=lock";

  outputs = {floxpkgs,...}: {
    dynamicInputs.vscode-pylint.url = {
      publish = "asdfas";
      owerner = "asdfas";
    };


    #"https://ms-python.gallery.vsassets.io/_apis/public/gallery/publisher/ms-python/extension/pylint/2022.1.11441003/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage";
  # inputs.vscode-pylint.flake = false;
  # # inputs.vscode-pylint.narHash = "sha256-rGq72APAph3+J+ggyyEBO3YokdVAS4CTxqRGc/aiwKY=";
  # inputs.vscode-pylint.type = "file";
   };

}
