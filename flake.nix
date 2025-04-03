{
  description = "Pacote personalizado do Vim com tema codedark";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default =
      let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; };

        codedark = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/tomasiser/vim-code-dark/master/colors/codedark.vim";
          sha256 = "sha256-4/BhTIj6tAkJ4d6fIQfQ5bEmPZ1LegEak0SR4TR0sZU=";
        };

        myVim = pkgs.vim_configurable.customize {
          name = "vim";
          vimrcConfig.customRC = ''
            syntax on
            filetype plugin indent on
            set nocompatible
            colorscheme codedark

            set background=dark
            set laststatus=2
            set cursorline
            set hlsearch
          '';
        };
      in pkgs.stdenv.mkDerivation {
        pname = "nix-vim-config";
        version = "1.0";
        src = ./.;  # 👈 ESSENCIAL

        buildInputs = [ myVim ];

	installPhase = ''
	  mkdir -p $out/bin
	  ln -s ${myVim}/bin/vim $out/bin/vim
	
	  mkdir -p $out/share/vim/vimfiles/colors
	  cp ${codedark} $out/share/vim/vimfiles/colors/codedark.vim
	
	  mkdir -p $out/etc
	  cat > $out/etc/vimrc <<EOF
	syntax on
	filetype plugin indent on
	set nocompatible
	colorscheme codedark
	
	set background=dark
	set laststatus=2
	set cursorline
	set hlsearch
	EOF
	'';
        meta = {
          description = "Custom Vim with codedark colorscheme";
          license = pkgs.lib.licenses.gpl3;
        };
      };
  };
}

