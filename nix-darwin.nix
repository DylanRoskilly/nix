{
  pkgs,
  self,
  secrets,
  ...
}:

{
  nix.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  ids.gids.nixbld = 350;

  system.configurationRevision = self.rev or self.dirtyRev or null;

  system.stateVersion = 4;

  nixpkgs.hostPlatform = "aarch64-darwin";

  nixpkgs.config.allowUnfree = true;

  users.users.${secrets.username} = {
    name = secrets.username;
    home = "/Users/${secrets.username}";
  };

  environment.systemPackages = [ ];

  fonts.packages = with pkgs; [
    jetbrains-mono
  ];

  security.pam.services.sudo_local.touchIdAuth = true;
}
