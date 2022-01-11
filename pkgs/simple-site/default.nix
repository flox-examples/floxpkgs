{ mkYarnPackage, ran, runtimeShell }:

mkYarnPackage {
  project = "simple-site";
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
    exec ${ran}/bin/ran -r $out/libexec/simple-site/deps/simple-site/src/bad "\$@"
    EOF
    chmod +x $out/bin/launch-hack
  '';
}
