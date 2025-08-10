{
  description = "MacOS System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-vscode-extensions,
      mac-app-util,
    }:
    let
      secrets = import ./secrets.nix;
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nix-vscode-extensions.overlays.default ];
      };
      darwinConfig = import ./nix-darwin.nix {
        inherit pkgs self secrets;
      };
      homeManagerConfig = import ./home.nix {
        inherit pkgs self secrets;
      };
    in
    {
      darwinConfigurations.${secrets.hostname} = nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          darwinConfig
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          {
            home-manager.backupFileExtension = "backup";
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.sharedModules = [ mac-app-util.homeManagerModules.default ];
            home-manager.users.${secrets.username} = homeManagerConfig;
          }
        ];
      };
    };
}
