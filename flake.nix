{
  

  # Declaration of external resources
  # =================================
  inputs.hello-python.url = "github:flox-examples/hello-python";
  inputs.hello-python.inputs.flox-floxpkgs.follows = "/";

  # =================================


  description = "Floxpkgs/Project Template";
  nixConfig.bash-prompt = "[flox] \\[\\033[38;5;172m\\]λ \\[\\033[0m\\]";

  # Template DO NOT EDIT
  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  # TODO: injected by the cli, or used via registry?
  inputs.flox-floxpkgs.url = "github:flox/floxpkgs";
  inputs.nixpkgs.url = "github:flox/nixpkgs-flox";
  inputs.nixpkgs.inputs.floxpkgs.follows = "flox-floxpkgs";
  outputs = args @ {flox-floxpkgs, ...}: flox-floxpkgs.capacitor args (import ./flox.nix);
  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}
