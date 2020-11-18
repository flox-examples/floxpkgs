{ flox, floxInternal }: flox.linkDotfiles (flox.getSource floxInternal.importingChannelArgs.name "dotfiles" {}).src
