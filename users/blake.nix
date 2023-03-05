{ config, ... }: {
  users.users.blake = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
