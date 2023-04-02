{
  age = {
    secrets = {
      # "git-signing-key" = rec {
      #   file = ../../secrets/ssh/git-signing-key.age;
      #   owner = "blake";
      #   path = "/home/${owner}/.ssh/git-signing-key";
      # };

      # "git-signing-key.pub" = rec {
      #   file = ../../secrets/ssh/git-signing-key.pub.age;
      #   owner = "blake";
      #   path = "/home/${owner}/.ssh/git-signing-key.pub";
      # };
    };
    identityPaths = [ "/agenix/id-ed25519-ssh-primary" ];
  };
}
