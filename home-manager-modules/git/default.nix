{ config, pkgs, osConfig, ... }: {
  programs.git = {
    enable = true;
    userName = "Blake Spiers";
    userEmail = "blakespiers93@gmail.com";
    extraConfig = {
      core.editor = "nvim";

      commit.gpgsign = true;
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile =
          config.home.file.".ssh/allowed_signers".source.outPath;
      };
      user.signingkey = osConfig.age.secrets."git-signing-key.pub".path;
    };
  };
}
