{ pkgs ? import <nixpkgs> {} }:

let
  codedark = pkgs.fetchFromGitHub {
    owner = "tomasiser";
    repo = "vim-code-dark";
    rev = "4624dc2";  # Commit existente!
    sha256 = "sha256-fCPetq4Wr/kuaT0Pcd6NSEAUBkkjbCE1PhTt0KLj9oI="; # fake sha
  };
in

pkgs.stdenv.mkDerivation {
  pname = "nix-vim-config";
  version = "1.0";

  src = ./.;

  nativeBuildInputs = [ pkgs.vim pkgs.git ];

  installPhase = ''
    mkdir -p $out/etc
    cp $src/vimrc $out/etc/vimrc

    mkdir -p $out/share/vim/vimfiles/colors
    cp ${codedark}/colors/codedark.vim $out/share/vim/vimfiles/colors/codedark.vim
  '';

  meta = {
    description = "Custom Vim configuration with codedark colorscheme";
    license = pkgs.lib.licenses.gpl3;
  };
}
