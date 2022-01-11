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
  '';
}
