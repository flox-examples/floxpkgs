{ flox, haskellPackages }:
flox.haskellPackages.mkDerivation {
  project = "hello-haskell";
  libraryHaskellDepends = [
    haskellPackages.hello-haskell-library
  ];
}
