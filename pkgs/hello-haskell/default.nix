{ flox, haskellPackages }:
flox.haskellPackages.mkDerivation {
  project = "hello-haskell";
  libraryHaskellDepends = [
    haskellPackages.haskell-library
  ];
}
