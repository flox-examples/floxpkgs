{ python3Packages }:

let
  # Prefix for python executable name.
  pyprefix = "gdal";
  # Python version to be wrapped.
  pythonPackages = python3Packages;
  inherit (pythonPackages) python;
  # Attribute set of python modules -> packages that they come
  # from, used to drive both the build and "smoke test".
  extraLibModules = {
    osgeo = "gdal";
    numpy = "numpy";
  };

in
  python.buildEnv.override {
    ignoreCollisions = true;
    extraLibs = map (pyPkg: pythonPackages.${pyPkg}) (builtins.attrValues extraLibModules);
    postBuild = ''
      tmpdir=`mktemp -d`
      # Retain the the gdal* symlinks as-is.
      mv $out/bin/${pyprefix}* $tmpdir
      # Rename and retain only the default python binaries.
      for i in $out/bin/python*; do mv $i $tmpdir/${pyprefix}$(basename $i); done
      # Move the customized bin directory into place.
      rm -rf $out/bin
      mv $tmpdir $out/bin
      # Perform a quick "smoke test" to ensure we have all the necessary imports.
      for i in ${builtins.toString (builtins.attrNames extraLibModules)}; do
        ( set -x && $out/bin/${pyprefix}python -c "import $i" )
      done
    '';
  }
