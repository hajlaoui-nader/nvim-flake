# Home Manager module
{ config, pkgs, lib ? pkgs.lib, ... }:

let
  cfg = config.programs.neovim-ide;
  neo = pkgs.neovimBuilder { config = cfg.settings; };
in
with lib; {
  meta.maintainers = [ maintainers.nhajlaoui ];

  options.programs.neovim-ide = {
    enable = mkEnableOption "NeoVim with LSP enabled for Scala, Haskell, Rust and more.";

    settings = mkOption {
      type = types.attrsOf types.anything;
      default = { };
      example = literalExpression ''
        {
          vim.viAlias = false;
          vim.vimAlias = true;
        }
      '';
      description = "Attribute set of neovim-ide preferences.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ neo ];
  };
}
