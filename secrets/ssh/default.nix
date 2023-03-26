let
  primarySshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF8zli4am7eWZGVEAaLsqd0xZyg/2NA4phXmD3ceIuAV";
  sshKeys = [ primarySshKey ];
in
{
  # SSH Signing Key
  "git-signing-key.age".publicKeys = sshKeys;
  "git-signing-key.pub.age".publicKeys = sshKeys;

  # "git-auth-key.age".publicKeys = sshKeys;
  # "git-auth-key.pub.age".publicKeys = sshKeys;
}
