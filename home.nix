{ config, pkgs, ... }:{
  # init
  home.username = "marci";
  home.stateVersion = "23.11";
  # Pkgs
  home.packages = [
    pkgs.hello
    pkgs.gtkcord4
  ];
}

