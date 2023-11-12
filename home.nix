{ config, pkgs, ... }:
let
  #home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz";
in
{
  # init
  imports = [
    (import "${home-manager}/nixos")
  ];
  home-manager.users.marci = {
    # init
    home.username = "marci";
    home.stateVersion = "23.05";
    # Pkgs
    home.packages = [
      pkgs.hello
      pkgs.gtkcord4
      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];
  };
}

