{
  pkgs,
  self,
  secrets,
  ...
}:

{
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    bashInteractive
    nil
    nixfmt-rfc-style
    nerd-fonts.jetbrains-mono
    eza
    helix
  ];

  fonts.fontconfig.enable = true;

  home.shellAliases = {
    ls = "eza -a";
    cd = "z";
  };

  programs.kitty = {
    enable = true;
    themeFile = "OneDark";
    font = {
      name = "JetBrainsMono NF";
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
        "workbench.colorTheme" = "Default Dark+";
        "workbench.iconTheme" = "material-icon-theme";
        "editor.fontFamily" = "JetBrainsMono NF";
        "editor.fontSize" = 15;
        "editor.formatOnSave" = true;
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;
        "files.autoSave" = "onFocusChange";
        "editor.inlayHints.enabled" = "offUnlessPressed";
        "editor.minimap.enabled" = false;
        "rust-analyzer.lens.enable" = false;
      };
      extensions = with pkgs.vscode-marketplace; [
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        zxh404.vscode-proto3
        yzhang.markdown-all-in-one
        usernamehw.errorlens
        pkief.material-icon-theme
        gruntfuggly.todo-tree
      ];
    };
  };
}
