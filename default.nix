import <nixexprs-lib> {
  name = "demo";

  auto.toplevel.path = ./pkgs;
  auto.python.path = ./pythonPackages;
  auto.perl.path = ./perlPackages;
}
