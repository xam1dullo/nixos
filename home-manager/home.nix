{ config, pkgs, ... }:

let
  # Import the unstable Nixpkgs package set
  unstablePkgs = import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
      # You can pin to a specific commit for reproducibility:
      # url = "https://github.com/NixOS/nixpkgs/archive/<commit-hash>.tar.gz";
    })
    {
      inherit (pkgs) system;
      config = {
        allowUnfree = true;
      };
    };
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  nixpkgs.config = {
    allowUnfree = true;
    nixpkgs.config = {
      allowUnfree = true;
    };

  };

  home.username = "khamidullo";
  home.homeDirectory = "/home/khamidullo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = (with pkgs; [
    # Add your stable packages here
    # Example:
    # git
    # curl
  ]) ++ (with unstablePkgs; [
    # Add your unstable packages here
    zed-editor
    vscode
    discord
    postman
    nodejs_22
    pnpm
  ]);

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/khamidullo/etc/profile.d/hm-session-vars.sh
  #
  # programs.alacritty = {
  #   enable = true;
  #   settings = {
  #     window.opacity = 0.95;

  #     font = {
  #       size = 14.0;
  #       normal = {
  #         family = "JetBrains Mono";
  #         style = "Bold";
  #       };
  #     };
  #     colors.primary.background = "#1d2021";
  #   };
  # };
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
