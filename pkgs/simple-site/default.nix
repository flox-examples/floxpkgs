{ mkYarnPackage }:

mkYarnPackage {
  project = "simple-site";
  postBuild = ''
    pushd deps/simple-site
    yarn run build
    popd
  '';
}
