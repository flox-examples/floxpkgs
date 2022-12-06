{
  

  # Declaration of external resources
  # =================================
  inputs.hello-python.url = "github:flox-examples/hello-python";
  inputs.hello-python.inputs.floxpkgs.follows = "/";

  # =================================


  description = "Floxpkgs/Project Template";
  nixConfig.bash-prompt = "[flox] \\[\\033[38;5;172m\\]λ \\[\\033[0m\\]";

  # Template DO NOT EDIT
  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  # TODO: injected by the cli, or used via registry?
  inputs.floxpkgs.url = "github:flox/floxpkgs";
  outputs = args @ {floxpkgs, ...}: floxpkgs.capacitor args (import ./flox.nix);
  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
}
