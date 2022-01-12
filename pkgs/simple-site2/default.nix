{ mkYarnPackage, ran, runtimeShell }:

mkYarnPackage {
  project = "simple-site";
  pname = "simple-site2";
  postBuild = ''
    pushd deps/simple-site
    yarn run build
    popd
  '';
  postInstall = ''
    cat > $out/bin/launch-simple-site <<EOF
    #!${runtimeShell} -x
    exec ${ran}/bin/ran -r $out/libexec/simple-site/deps/simple-site/public "\$@"
    EOF
    chmod +x $out/bin/launch-simple-site
    cat > $out/bin/launch-hack <<EOF
    #!${runtimeShell} -x
    exec ${ran}/bin/ran -r $out/libexec/simple-site/deps/simple-site/src/bad -p 8081 "\$@"
    EOF
    chmod +x $out/bin/launch-hack
    rm $out/libexec/simple-site/deps/simple-site/node_modules -rf
    rm $out/libexec/simple-site/node_modules -rf
  '';
  distPhase = ":";
}
