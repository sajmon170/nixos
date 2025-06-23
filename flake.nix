{
  description = "Simon's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    firefox-gnome-theme = {
        url = "github:rafaelmardojai/firefox-gnome-theme/master";
        flake = false;
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, firefox-gnome-theme, ... }: {
    nixosConfigurations.sajmon-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
                inherit firefox-gnome-theme;
            };
            home-manager.users.sajmon = ./home.nix;
          }
      ];
    };
  };
}
