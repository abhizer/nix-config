{ pkgs, ... }:
{
  home.sessionVariables = {
    DEFAULT_MINIO_ENDPOINT = "http://localhost:9000";
    EDITOR = "nvim";
    PKG_CONFIG_PATH = "${pkgs.zstd.dev}/lib/pkgconfig:${pkgs.cyrus_sasl.dev}/lib/pkgconfig:${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.lz4.dev}/lib/pkgconfig:${pkgs.krb5.dev}/lib/pkgconfig";
    LD_LIBRARY_PATH = "${pkgs.zstd.out}/lib:${pkgs.cyrus_sasl.out}/lib:${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.krb5.lib}/lib:${pkgs.lz4.lib}/lib:/nix/store/nr8mh99sfsb1gw1b1qmrwhzmxbhj84j7-libxml2-2.13.3/lib";
    LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.dev.lib}/lib";
    CLANG_RESOURCE_DIR = "${pkgs.clang}/resource-root/include";
  };
}
