{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      prompt = "Search...";
      term = lib.getExe pkgs.wezterm;
      width = 550;
      height = 420;
      allow_markup = true;
      image_size = 18;
      gtk_dark = true;
    };
    style = ''
      window {
        font-family: "Noto Sans", sans-serif;
        font-size: 14px;
        margin: 0px;
        border: 1px solid #5e81ac;
        background-color: #2e3440;
      }

      #input {
        margin: 5px;
        border: none;
        color: #d8dee9;
        background-color: #3b4252;
      }

      #inner-box,
      #outer-box {
        margin: 5px;
        border: none;
        background-color: #2e3440;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 4px;
        border: none;
        color: #d8dee9;
      }

      #text:selected {
        background: none;
      }

      #entry:selected {
        background-color: #3b4252;
      }
    '';
  };
}
