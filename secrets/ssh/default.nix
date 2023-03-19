let
  primarySshKey =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEcXDs9EInjfj/xLo8tRup5Xk/+832W8qOHUyDi9W5BJ";
  sshKeys = [ primarySshKey ];
in
{
  # SSH Signing Key
  "git-signing-key.age".publicKeys = sshKeys;
  "git-signing-key.pub.age".publicKeys = sshKeys;

  "git-auth-key.age".publicKeys = sshKeys;
  "git-auth-key.pub.age".publicKeys = sshKeys;
}
