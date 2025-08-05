{inputs, pkgs, ...}:
{
  home.packages = with pkgs; [
    hyprland
    swww # wallpaper
    grimblast # screenshot
    hyprpicker # colorpicker
    grim # grab images from a wayland compositor
    slurp # wayland compositor
    wl-clip-persist # clipboard
    wl-clipboard-rs
    xclip
    cliphist # wayland clipboard manager
    wf-recorder # screen recording of wlroots-based compositors
    playerctl # music play pause
    pamixer # audio volume
    glib
    wayland
    xwayland
    direnv
    xdg-desktop-portal-hyprland
  ];

  systemd.user.targets.hyprland-session.Unit.Wants = [
    "xdg-desktop-autostart.target"
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;

    xwayland = {
      enable = true;
    };

    systemd.enable = true;
  };
}
