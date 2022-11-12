{ pkgs, ... }:

{
	home = {
		packages = with pkgs; [
			firefox
			tmux
			ripgrep
			fd
			emacs
			spotify
			starship
			neovim
		];

		stateVersion = "22.05";
	};

	programs = {
		git = {
			enable = true;
			userName = "Blake Spiers";
			userEmail = "blakespiers93@gmail.com";
			extraConfig = {
				core.editor = "nvim";
			};
		};

		alacritty = {
			enable = true;
			settings = {
				shell.program = "${pkgs.fish}/bin/fish";

				window = {
					startup_mode = "Fullscreen";
				};

				font = {
					normal.family = "Hack Nerd Font Mono";
					bold.family = "Hack Nerd Font Mono";
					italic.family = "Hack Nerd Font Mono";
					size = 8.0;
					offset = {
						x = 0;
						y = 0;
					};
					glyph_offset = {
						x = 0;
						y = 0;
					};
				};
			};
		};

		fish = {
			enable = true;
			interactiveShellInit = "
				starship init fish | source
			";
		};
	};
}
