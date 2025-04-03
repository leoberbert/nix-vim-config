{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "nix-vim-config";
  version = "1.0";
  src = ./.;

  nativeBuildInputs = with pkgs; [ vim git ];

  installPhase = ''
    mkdir -p $out/etc
    cp ${src}/vimrc $out/etc/vimrc

    mkdir -p $out/share/vim/vimfiles/colors
    curl -L https://raw.githubusercontent.com/tomasiser/vim-code-dark/master/colors/codedark.vim \
      -o $out/share/vim/vimfiles/colors/codedark.vim
  '';

  meta = {
    description = "Custom Vim configuration with codedark colorscheme";
    license = pkgs.lib.licenses.gpl3;
  };
}
