# Secrets - Or: "Yo, nice try boss! As if I was going to save plaintext here"

So getting this setup initially busted me as I was derping hard on how to do this. But I think I've got it now and we're good to get some cool stuff going!

## Getting Agenix Locally

You can follow the [tutorial](https://github.com/ryantm/agenix#tutorial) Ryan has given in the repo, but what wasn't initially obvious was that overlays are your friend here.

Do it however you wish, I found the following the easiest: add agenix to your inputs:

```nix
{
    agenix = {
        url = "github:ryantm/agenix";
        inputs.nixpkgs.follows = "unstable"; # or whatever your nixpkgs is called
    };
}
```

Then add the overlay to your system overlays however you prefer, in my instance this looks like:

```nix
{
    x86_64-linux = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ agenix.overlay ]; # This is hidden behind an overlay array in my use, but will work with this line also.
        config = { allowUnfree = true; };
    };
}
```

From here as long as you use either an ephemeral shell or include agenix in packages to be installed you should be :neckbeard:

## Getting Secrets Flowin'

From here just follow the tutorial linked previously, in essence:

Generate some SSH keys - consider just dropping the identity associated with the key and make sure this is the single use of those keys:

```sh
ssh-keygen -t ed25519 -C "" -f /tmp/test_key
```

I made a secondary key also, from my understanding this will help if a single key is compromised in rolling the secrets without using the existing compromised key (Don't forget to roll the enclosed secret if you need in this instance)

Then just generate your new secret:

```sh
agenix -e ./test.age -i /tmp/test_key
```

## Rolling Secrets

Simply:

```sh
agenix --rekey --identity ~/.ssh/id_ed25519_agenix_secondary
```

## Adding Secrets To A System

[tldr rtfm](https://github.com/ryantm/agenix/blob/main/modules/age.nix)

At current time of writing a system can use the following options:

```nix
{
    name = mkOption {
        type = types.str;
        default = config._module.args.name;
        description = ''
          Name of the file used in ${cfg.secretsDir}
        '';
    };

    file = mkOption {
        type = types.path;
        description = ''
          Age file the secret is loaded from.
        '';
    };

    path = mkOption {
        type = types.str;
        default = "${cfg.secretsDir}/${config.name}";
        description = ''
            Path where the decrypted secret is installed.
        '';
    };

    mode = mkOption {
        type = types.str;
        default = "0400";
        description = ''
          Permissions mode of the decrypted secret in a format understood by chmod.
        '';
    };

    owner = mkOption {
        type = types.str;
        default = "0";
        description = ''
          User of the decrypted secret.
        '';
    };

    group = mkOption {
        type = types.str;
        default = users.${config.owner}.group or "0";
        description = ''
          Group of the decrypted secret.
        '';
    };

    symlink = mkEnableOption "symlinking secrets to their destination" // { default = true; };
}
```

## My Walkthrough

Create one or more host SSH keys for agenix, these should exist in `/agenix/`.
Impose access restrictions on private keys in `/agenix/` with `chmod`.
Add the respective public keys to `secrets/ssh/default.nix`.

### Chown and Chmod

Set user and group permissions for access to host SSH keys in `/agenix/`

```shell
sudo chown blake:root /agenix/
sudo chmod 550 /agenix/
sudo chown blake:users /agenix/id-ed25519-ssh-primary
sudo chmod 600 /agenix/id-ed25519-ssh-primary
```

### SSH Example

Define `"secret".publicKeys` in `secrets/ssh/default.nix`, to inform agenix of which keys to encrypt matching files with.

Add secrets to agenix by navigating to `secrets/ssh` and execting the command:
`agenix -e secret1.age` (Which key does this use to encrypt?)
Your default editor will open, allowing you to modify the content of secret1.age.
Upon closing the editor, the contents will be saved and encrypted using your defined public keys.
The encrypted file will now exist in the working directory used to execute the above command.
Agenix will now know which host keys to use for encrypting and decrypting the contents of `secret1.age`.

#### Host Age Config

On user login, Agenix will use the private host keys, in the defined host identityPaths (`/agenix/myPrivateKey`) to
decrypt the declared secrets and add them to a temp directory under `/run/agenix/`.

```nix
age = {
    secrets = {
        "git-signing-key" = rec {
            file = ../../secrets/ssh/git-signing-key.age;
            owner = "blake";
            path = "/home/${owner}/.ssh/git-signing-key";
        };
    }
}
```

The secrets are fetched from the location of their `file` attribute, decrypted into `/agenix/` and symlinked from `/.ssh/`.

Permissions to access these secrets are granted to the users defined by `owner`???

#### Referring To Secrets In Config

Secrets that are decrypted this way, may be referred to in nix configuration, as follows:

```nix
user.signingkey = osConfig.age.secrets."git-signing-key.pub".path;
```

## Layout

Identity `id-ed25519-ssh-primary` should exist in `/agenix/`.
Secrets like `git-signing-key.age` and `blake-id-ed25519-1.age` should exist in `**/nix-config/secrets/ssh/`.
Secrets from `**/nix-config/secrets/ssh/` are decrypted into `/run/agenix/`.
Symlinks for decrypted secrets exist as defined in config (by default `~/.ssh/`).
