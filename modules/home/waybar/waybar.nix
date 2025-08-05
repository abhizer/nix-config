{pkgs, ... }:
{
  home.packages = with pkgs; [ waybar networkmanagerapplet ];
  programs.waybar = {
    enable = true;
  };
}
