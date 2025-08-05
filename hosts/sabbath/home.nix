{ inputs, config, system, pkgs, stable, ... }:

{
  home.username = "abhizer";
  home.homeDirectory = "/home/abhizer";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = [
    pkgs.spotify
    pkgs.rclone
    pkgs.rclone-ui
    pkgs.jetbrains.rust-rover
    pkgs.zoom-us
    pkgs.eza
    pkgs.kitty
    pkgs.neofetch
    pkgs.xclip
    pkgs.slack
    pkgs.devenv
    pkgs.ripgrep
    pkgs.delta
    pkgs.light
    pkgs.pre-commit
    pkgs.unzip
    pkgs.code-cursor
    pkgs.swaynotificationcenter

    pkgs.dconf

    # Rust
    pkgs.rustup
    # pkgs.cargo
    # pkgs.rustc
    pkgs.clang
    pkgs.llvmPackages.libclang.dev
    pkgs.libxml2
    # pkgs.rust-analyzer
    # pkgs.clippy
    # pkgs.rustfmt

    pkgs.zlib
    pkgs.lz4
    pkgs.krb5
    pkgs.krb5.out

    pkgs.kubernetes-helm
    pkgs.kubectl
    pkgs.k3d
    pkgs.just
    pkgs.awscli2
    pkgs.eksctl
    pkgs.openssl

    # Java
    pkgs.jdk
    pkgs.maven

    # Bun
    pkgs.bun
    pkgs.nodejs_20
    # stable.nodePackages_latest.rollup

    # Feldera Web Console
    pkgs.sass

    # Python
    pkgs.python3
    pkgs.uv

    # Build tools
    pkgs.gnumake
    pkgs.openssl.dev
    pkgs.pkg-config
    pkgs.glibc
    pkgs.libcxx
    pkgs.libgcc
    pkgs.cmake
    pkgs.gsasl
    pkgs.cyrus_sasl.dev
    pkgs.cyrus_sasl.out
    pkgs.zstd.dev
    pkgs.zstd.out
    
    pkgs.jq

    pkgs.obs-studio
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    DEFAULT_MINIO_ENDPOINT = "http://localhost:9000";
    EDITOR = "nvim";
    PKG_CONFIG_PATH = "${pkgs.zstd.dev}/lib/pkgconfig:${pkgs.cyrus_sasl.dev}/lib/pkgconfig:${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.lz4.dev}/lib/pkgconfig:${pkgs.krb5.dev}/lib/pkgconfig";
    # LD_LIBRARY_PATH = "${pkgs.zstd.out}/lib:${pkgs.cyrus_sasl.out}/lib:${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.krb5.lib}/lib:${pkgs.lz4.lib}/lib:/nix/store/nr8mh99sfsb1gw1b1qmrwhzmxbhj84j7-libxml2-2.13.3/lib";
    LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.dev.lib}/lib";
    CLANG_RESOURCE_DIR = "${pkgs.clang}/resource-root/include";
  };

  qt.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
