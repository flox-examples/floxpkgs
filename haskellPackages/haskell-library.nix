{ flox, acme-missiles }:
flox.haskellPackages.mkDerivation {
  project = "haskell-library";
  libraryHaskellDepends = [
    acme-missiles
  ];
}
