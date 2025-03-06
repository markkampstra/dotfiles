{
  packageOverrides = pkgs: with pkgs; {
    myPackages = pkgs.buildEnv {
      name = "my-tools";
      paths = [
        zsh-completions
        neovim
        nodejs_22
        fd
        ripgrep
        fzf
        lazygit
      ];
    };
  };
}
