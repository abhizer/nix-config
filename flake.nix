{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable-nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, stable-nixpkgs, home-manager, ... }@inputs:
    let 
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      stable = stable-nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        sabbath = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs system stable; };
          modules = [
            ./hosts/sabbath/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };

      homeConfigurations = {
        sabbath = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/sabbath/home.nix
            ./modules/home
          ];

          extraSpecialArgs = { inherit inputs system stable; };
        };
      };
    };
}
