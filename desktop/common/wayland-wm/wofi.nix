{ lib, pkgs, ... }:
{
  programs.wofi.enable = true;
  programs.wofi.settings = {
    show = "drun";
    prompt = "Search...";
    term = lib.getExe pkgs.ghostty;
    width = 500;
    height = 420;
    allow_images = true;
    hide_scroll = true;
    print_command = true;
    columns = 1;
    no_actions = true;
    insensitive = true;
  };

  programs.wofi.style = ''
    @import url(".config/wofi/colors.css");
    @keyframes fadeIn {
        0% {
        }
        100% {
        }
    }

    * {
        all: unset;
        font-family: "Inter Display", "Symbols Nerd Font";
        padding: 0;
        margin: 0;
    }

    window#window {
        background-color: transparent;
        font-size: 18px;
    }

    #outer-box {
        padding: 20px;
        border-radius: 0px;
        background-color: alpha(@background, 0.5);
    }

    #scroll {
        margin: 0px;
        padding: 30px;
    }

    #inner-box {
        margin: 2px;
        padding: 5px;
    }

    #entry {
        margin: 5px;
        padding: 10px;
    }

    #entry arrow {
        color: @inactive;
    }

    #entry:selected {
        border-radius: 15px;
        background-color: alpha(@active, 0.3);
    }

    #entry:selected #text {
        color: @inacive;
    }

    #entry:drop(active) {
        background-color: @foreground;
    }

    #input {
        color: @foreground;
        margin-top: 20px;
        margin-left: 20px;
        margin-right: 20px;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 1px 1px 5px alpha(#1c1c1c, 0.5);
        background-color: alpha(@background-alt, 0.2);
    }

    #input image {
        color: @inactive;
        padding-right: 10px;
    }

    #input:focus {
        box-shadow: 1px 1px 5px alpha(#1c1c1c, 0.8);
    }

    #text {
        color: @foreground;
        margin: 5px;
    }
  '';
}
