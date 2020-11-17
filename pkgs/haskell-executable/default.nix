{ flox, haskellPackages }:
flox.haskellPackages.mkDerivation {
  project = "haskell-executable";
  libraryHaskellDepends = [
    haskellPackages.haskell-library
  ];
}
