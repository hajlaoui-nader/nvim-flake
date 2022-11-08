{ pkgs, neovimBuilder, ... }:

# configuration with sane defaults to use directly via nix run
neovimBuilder {
  config = {
    vim = {
      viAlias = false;
      vimAlias = true;
    #   preventJunkFiles = true;
    #   cmdHeight = 2;
    #   customPlugins = with pkgs.vimPlugins; [
    #     multiple-cursors
    #     vim-repeat
    #     vim-surround
    #     copilot-vim
    #   ];
      
    };
  };
}
