# Nix expressions for Flox examples

This repository contains the Nix expressions for the flox-examples channel.

The following sections show how packages from this or other channels can be installed.

## Setting up a channel dependency

If you want to try building these examples, you need to specify that your floxpm user depends on this channel. The way to do this is by adding `"flox-examples"` to `channels.json` in your users floxpkgs repository:

1. Follow the instructions for creating your floxpkgs repository [here](https://beta.floxdev.com/docs/developer-guide/make_channel/), if you haven't already done so already
2. Add a `channels.json` file to your floxpkgs with contents
    ```json
    [
      "flox-examples"
    ]
    ```
3. Commit and push this change to the repository
4. Verify that flox-examples is available in your floxpm installation with
    ```bash
    $ nix-instantiate --find-file flox-examples
    ```

## Installing example packages

Once you set up the channel dependency, you'll be able to install the examples in this repository. E.g. to install the [hello-python](./pkgs/hello-python) package:

```bash
$ floxpm install $(nix-build --no-out-link '<flox-examples>' \
  --argstr name flox-examples -A hello-python)
```

Now the binary of the package can be run:

```bash
$ hello
Hello world!
```
