{ haskellPackages }:
haskellPackages.mkDerivation {
  project = "hello-haskell";
  libraryHaskellDepends = [
    haskellPackages.hello-haskell-library
  ];
}
