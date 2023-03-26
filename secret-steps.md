Generate sshkey for host home-desktop:
`ssh-keygen -t ed25519 -C "" -f /home/blake/.ssh/id-ed25519-ssh-primary`

Add the contents of `/home/blake/.ssh/id-ed25519-ssh-primary.pub` as primarySshKey in `secrets/ssh/default.nix`

Temporarily generate an ssh key for git signing:
`ssh-keygen -t ed25519 -C "" -f /tmp/git-signing-key`

Encrypt the contents of `git-signing-key` and `git-signing-key.pub` into their respective age files:
`cd nix-config/secrets/ssh`
`agenix -e git-signing-key.age`
`agenix -e git-signing-key.pub.age`

Responses:
`cp: cannot stat '/tmp/tmp.wFkpO9ClDp/git-signing-key.pub.age': No such file or directory`
`cp: cannot stat '/tmp/tmp.7lnkNqVsJP/git-signing-key.age': No such file or directory`

ls `nix-config/secrets/ssh`:
`default.nix git-signing-key.age git-signing-key.pub.age secrets.nix`

Git singing key pair age files are editable with:
`agenix -e git-signing-key.age -i /home/blake/.ssh/id-ed25519-ssh-primary`
`agenix -e git-signing-key.pub.age -i /home/blake/.ssh/id-ed25519-ssh-primary`

Adding secrets to `hosts/home-desktop/secrets.nix`:

```nix
{
  age = {
    secrets = {
      "git-signing-key" = rec {
        file = ../../secrets/ssh/git-signing-key.age;
        owner = "blake";
        path = "/home/${owner}/.ssh/git-signing-key";
      };

      "git-signing-key.pub" = rec {
        file = ../../secrets/ssh/git-signing-key.pub.age;
        owner = "blake";
        path = "/home/${owner}/.ssh/git-signing-key.pub";
      };
    };
    identityPaths = [ "/agenix/id-ed25519-ssh-primary" ];
  };
}
```

Followed by a `nixos-rebuild switch --flake .#home-desktop --use-remote-sudo` results in:

```nix
[agenix] creating new generation in /run/agenix.d/2
[agenix] decrypting secrets...
[agenix] WARNING: config.age.identityPaths entry /agenix/id-ed25519-ssh-primary not present!
decrypting '/nix/store/zmw43qmhrig0hwsmrs9jz90prdkymmci-git-signing-key.age' to '/run/agenix.d/2/git-signing-key'...
[agenix] WARNING: no readable identities found!
Error: Missing identities.
Did you forget to specify -i/--identity?


[ Did rage not do what you expected? Could an error be more useful? ]
[ Tell us: https://str4d.xyz/rage/report                            ]
chmod: cannot access '/run/agenix.d/2/git-signing-key.tmp': No such file or directory
mv: cannot stat '/run/agenix.d/2/git-signing-key.tmp': No such file or directory
decrypting '/nix/store/h48zvffxz09x9c5y72a81ah8gjk2nakw-git-signing-key.pub.age' to '/run/agenix.d/2/git-signing-key.pub'...
[agenix] WARNING: no readable identities found!
Error: Missing identities.
Did you forget to specify -i/--identity?


[ Did rage not do what you expected? Could an error be more useful? ]
[ Tell us: https://str4d.xyz/rage/report                            ]
chmod: cannot access '/run/agenix.d/2/git-signing-key.pub.tmp': No such file or directory
mv: cannot stat '/run/agenix.d/2/git-signing-key.pub.tmp': No such file or directory
[agenix] symlinking new secrets to /run/agenix (generation 2)...
[agenix] removing old secrets (generation 1)...
Activation script snippet 'agenixInstall' failed (1)
[agenix] chowning...
chown: cannot access '/run/agenix.d/2/git-signing-key': No such file or directory
chown: cannot access '/run/agenix.d/2/git-signing-key.pub': No such file or directory
Activation script snippet 'agenixChown' failed (1)
```

`git-signing-key` and `git-signing-key.pub` now appear (with red text) in `~/home/blake/.ssh/`
`/run/agenix.d/2/` is an empty directory.
