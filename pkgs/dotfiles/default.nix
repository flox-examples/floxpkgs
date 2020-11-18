{ flox, meta }:
flox.linkDotfiles (meta.getSource "dotfiles" {}).src
