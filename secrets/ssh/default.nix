let
  primarySshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF8zli4am7eWZGVEAaLsqd0xZyg/2NA4phXmD3ceIuAV";
  sshKeys = [ primarySshKey ];
in
{
  # Secrets SSH keys - in this instance all hard-tokens so
  # threat modeling would require physical access to fully
  # compromise anyway.
  # Here we use a prefix of $USERNAME- so we can dynamically
  # generate suitable configs re; identity files and whatnot
  "blake-id-ed25519-1.age".publicKeys = sshKeys;

  # SSH Signing Key
  "git-signing-key.age".publicKeys = sshKeys;
  "git-signing-key.pub.age".publicKeys = sshKeys;
}
