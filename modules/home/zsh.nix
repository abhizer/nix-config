{...}:
{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
    };
    syntaxHighlighting = {
      enable = true;
    };
    enableCompletion = true;
    initContent = ''
      eval "$(starship init zsh)"
      eval "$(zoxide init zsh)"
    '';

    shellAliases = {
      cd = "z";
      hms = "home-manager switch --flake .#sabbath";
      nrs = "sudo nixos-rebuild switch --flake .#sabbath";
      crf = "cargo run --bin=pipeline-manager";
      cre = "cargo run --bin=pipeline-manager --features feldera-enterprise";
    };
  };
}
