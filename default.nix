{ stdenv, fetchgit, vim, git }:

stdenv.mkDerivation rec {
  pname = "nix-vim-config";
  version = "1.0";

  src = ./.;

  nativeBuildInputs = [ git vim ];

  installPhase = ''
    mkdir -p $out/etc
    cp ${src}/vimrc $out/etc/vimrc

    mkdir -p $out/share/vim/vimfiles/pack/git-plugins/start
    git clone https://github.com/tomasiser/vim-code-dark $out/share/vim/vimfiles/pack/git-plugins/start/vim-code-dark

    mkdir -p $out/share/vim/vimfiles/colors
    cp $out/share/vim/vimfiles/pack/git-plugins/start/vim-code-dark/colors/codedark.vim \
       $out/share/vim/vimfiles/colors/codedark.vim
  '';

  meta = {
    description = "Custom Vim configuration with codedark colorscheme";
    license = stdenv.lib.licenses.gpl3;
  };
}
