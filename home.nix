{
  pkgs,
  self,
  secrets,
  ...
}:

{
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    # rust
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer
    cargo-nextest

    # python
    python3
    uv
    mypy
    ruff

    # js
    nodejs
    typescript
    pnpm
    prettier
    eslint

    # nix
    nil
    nixfmt-rfc-style

    # typst
    typst
    tinymist

    # cli
    bashInteractive
    eza
    helix
  ];

  home.shellAliases = {
    ls = "eza -a";
    cd = "z";
  };

  programs.kitty = {
    enable = true;
    themeFile = "OneDark";
    font = {
      name = "JetBrains Mono";
      size = 15;
    };
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g mouse on

      # map prefix to C-a
      unbind C-b
      set-option -g prefix C-a
      bind-key C-a send-prefix

      # fix colours
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"
    '';
  };

  programs.git = {
    enable = true;
    userName = secrets.gitUserName;
    userEmail = secrets.gitEmail;
    extraConfig = {
      core.editor = "code --wait";
    };
    ignores = [ ".DS_Store" ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "eastwood";
      plugins = [ "git" ];
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      userSettings = {
        "extensions.autoCheckUpdates" = false;

        # appearance
        "workbench.colorTheme" = "Catppuccin Frappé";
        "workbench.iconTheme" = "material-icon-theme";
        "editor.fontFamily" = "JetBrains Mono";
        "editor.fontSize" = 15;
        "editor.inlayHints.enabled" = "offUnlessPressed";
        "editor.minimap.enabled" = false;

        # saving
        "editor.formatOnSave" = true;
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;
        "files.autoSave" = "onFocusChange";

        # extensions
        "rust-analyzer.lens.enable" = false;
        "rewrap.autoWrap.enabled" = true;
        "rewrap.wrappingColumn" = 80;
      };
      extensions = with pkgs.vscode-marketplace; [
        # themes
        catppuccin.catppuccin-vsc
        pkief.material-icon-theme

        # lsp
        myriad-dreamin.tinymist
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        zxh404.vscode-proto3
        yzhang.markdown-all-in-one

        # tools
        usernamehw.errorlens
        dnut.rewrap-revived
        gruntfuggly.todo-tree
      ];
    };
  };
}
