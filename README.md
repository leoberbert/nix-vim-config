# Vim flake com tema codedark

Este repositório define um pacote Nix que fornece uma versão personalizada do **Vim** com o esquema de cores `codedark` e várias configurações de qualidade de vida para HTML, Python e YAML.

## ✨ Funcionalidades

- Tema `codedark` incluído diretamente
- `vim_configurable` com configurações de indentação específicas
- Suporte a mouse
- Statusline personalizada
- Busca inteligente, compatibilidade UTF-8 e mais

---

## 🚀 Como usar no seu sistema NixOS (sem usar flakes como sistema)

Se você ainda não está usando flakes no `configuration.nix` principal, você pode usar este pacote diretamente assim:

### 1. Habilite os recursos experimentais (se ainda não tiver):

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

### 2. Importe o pacote no `configuration.nix`

Logo no topo (ou dentro de um `let`), adicione:

```nix
let
  my-vim = (builtins.getFlake "github:leoberbert/nix-vim-config").packages.${pkgs.system}.default;
in
```

### 3. Adicione `my-vim` à sua lista de pacotes do sistema:

```nix
environment.systemPackages = with pkgs; [
  wget
  git
  ...
  my-vim
];
```

### 4. Rebuild

```bash
sudo nixos-rebuild switch
```

---

## 🛠️ Build local (para testar)

Você também pode clonar este repositório e executar:

```bash
nix build
./result/bin/vim
```

---

## ⚠️ Warnings

Durante a build, pode aparecer o seguinte aviso:

```
warning: In a derivation named 'neovim-unwrapped-0.9.5', 'structuredAttrs' disables the effect of the derivation attribute 'disallowedRequisites'; use 'outputChecks.<output>.disallowedRequisites' instead
```

Esse warning **é inofensivo** e vem do `vim_configurable` ou plugins dependentes. Pode ignorar com segurança.

---

## 📁 Estrutura do projeto

- `flake.nix`: define o pacote Vim com as configurações incluídas

---

Feito com 💙 por Leoberbert

