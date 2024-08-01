{ config, pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;

  # Locale settings
  time.timeZone = "Europe/Berlin";
  console.keyMap = "de";

  environment.systemPackages = with pkgs; [
    btop
    hexyl
    htop
    termimage
    tree
    rsync
    qrencode
    qrscan
  ];

  environment.shellAliases = {
    qr = "qrencode -t ansiutf8i";
  };

  services.openssh = {
    enable = true;
    openFirewall = true;
    settings.PermitRootLogin = "yes";
  };

  # Automatically log in at the virtual console
  services.getty.autologinUser = "root";
  users.users.root.password = "";

  console.colors = [
    "000000" "800000" "008000" "808000"
    "004380" "800080" "0095db" "c0c0c0"
    "808080" "ff0000" "00ff00" "ffff00"
    "0000ff" "ff00ff" "00ffff" "ffffff"
  ];

  programs.tmux.enable = true;
  programs.tmux.extraConfig = ''
    set-window-option -g window-status-current-style bg=colour6,fg=colour15
    set -g status-style bg=colour4,fg=colour15
    set -g status-right '#[fg=colour8]#h #(ip addr | grep -e "state UP" -A 2 | awk "/inet /{printf \"%%s \", \$2}")#[bg=colour6,fg=colour8]%b %d %y %H:%M'
  '';

  programs.bash.interactiveShellInit = ''
    [ -z "$TMUX"  ] && { tmux attach || exec tmux new-session; }
  '';

  # Only available on iso builds
  #isoImage.appendToMenuLabel = "";
  system.nixos.distroName = "Custom NixOS";

  system.stateVersion = "24.05";
}
