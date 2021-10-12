# Dotfiles

This example shows a simple way to manage dotfiles in your home directory with Flox.

## Usage

1. Set up the dependency on the flox-examples channel by following the instructions in [the toplevel Readme](https://github.com/flox-examples/floxpkgs#setting-up-a-channel-dependency).
2. Install this package with
    ```bash
    $ floxpm install $(nix-build --no-out-link '<flox-examples>' \
      --argstr name flox-examples -A dotfiles-inline)
    ```
3. Set up the dotfiles by running
    ```bash
    $ setup-dotfiles
    Establishing dotfile symlinks from /nix/profiles/Infinisil/default/share/dotfiles in /home/ec2-user
    '/nix/profiles/Infinisil/default/share/dotfiles/.vimrc' -> '/home/ec2-user/.vimrc'
    ```

This command sets up all dotfiles declared in the [home](./home) directory. Note that even though there's also a [.bashrc](./home/.bashrc) declared, it didn't establish a link for that, because this user already had a `~/.bashrc`.

If you copy this example into your own floxpkgs, you can customize the [home](./home) directory to contain your own dotfiles. So if you wanted to have Flox manage your `~/.bashrc`, you would move that file into the [home](./home) directory and run `setup-dotfiles` again.

## Auto-updating of dotfiles

Once a set of dotfiles are installed, they are updated automatically by just pushing changes to the [home](./home) directory of the floxpkgs repository.

## Adding and removing of dotfiles currently does *not* work

If you add new dotfiles to the [home](./home) directory, they won't appear in your `$HOME` automatically. To make them appear, run `setup-dotfiles` again

Similarly, removing dotfiles from the [home](./home) directory won't remove them from your `$HOME`. You'll have to manually `rm` these.
