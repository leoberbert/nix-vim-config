let
  pkgs = import <nixpkgs> {};
in

pkgs.stdenv.mkDerivation rec {
  pname = "nix-vim-config";
  version = "1.0";

  src = ./.;

  nativeBuildInputs = [ pkgs.vim ];

  installPhase = ''
    mkdir -p $out/etc
    cp ${src}/vimrc $out/etc/vimrc

    mkdir -p $out/share/vim/vimfiles
    cp -r ${src}/pack $out/share/vim/vimfiles/
  '';

  meta = {
    description = "Custom Vim configuration with codedark colorscheme";
    license = pkgs.lib.licenses.gpl3;
  };
}

