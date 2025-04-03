{
  description = "Pacote personalizado do Vim com tema codedark";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        codedark = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/tomasiser/vim-code-dark/master/colors/codedark.vim";
        #sha256 = pkgs.lib.fakeSha256;
        sha256 = "sha256-4/BhTIj6tAkJ4d6fIQfQ5bEmPZ1LegEak0SR4TR0sZU=";
        };

      in
        pkgs.stdenv.mkDerivation {
          pname = "nix-vim-config";
          version = "1.0";
          src = ./.;

          nativeBuildInputs = [ pkgs.vim ];

          installPhase = ''
            mkdir -p $out/etc
            cp $src/vimrc $out/etc/vimrc

            mkdir -p $out/share/vim/vimfiles/colors
            cp ${codedark} $out/share/vim/vimfiles/colors/codedark.vim
          '';

          meta = {
            description = "Custom Vim configuration with codedark colorscheme";
            license = pkgs.lib.licenses.gpl3;
          };
        };
  };
}
