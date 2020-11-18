{ linkDotfiles, flox, floxInternal }: linkDotfiles (flox.getSource floxInternal.importingChannelArgs.name "dotfiles" {}).src
