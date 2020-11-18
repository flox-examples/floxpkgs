{ flox, acme-missiles }:
flox.haskellPackages.mkDerivation {
  project = "hello-haskell-library";
  libraryHaskellDepends = [
    acme-missiles
  ];
}
