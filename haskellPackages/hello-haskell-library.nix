{ mkDerivation, acme-missiles }:
mkDerivation {
  project = "hello-haskell-library";
  libraryHaskellDepends = [
    acme-missiles
  ];
}
