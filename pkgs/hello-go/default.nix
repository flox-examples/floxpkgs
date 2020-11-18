{ flox }:
flox.buildGoPackage {
  project = "hello-go";
  goPackagePath = "github.com/flox-examples/hello-go";
  goDeps = ./deps.nix;
}
