{
  description = "Vim configuration by Leoberbert";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default = let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
      };
    in pkgs.stdenv.mkDerivation {
      pname = "nix-vim-config";
      version = "1.0";

      src = ./.;

      nativeBuildInputs = [ pkgs.curl ];

      installPhase = ''
        mkdir -p $out/etc
        cp ${./vimrc} $out/etc/vimrc

        mkdir -p $out/share/vim/vimfiles/colors
        curl -L https://raw.githubusercontent.com/tomasiser/vim-code-dark/master/colors/codedark.vim \
          -o $out/share/vim/vimfiles/colors/codedark.vim
      '';

      meta = {
        description = "Custom Vim configuration with codedark colorscheme";
        license = pkgs.lib.licenses.gpl3;
      };
    };
  };
}
