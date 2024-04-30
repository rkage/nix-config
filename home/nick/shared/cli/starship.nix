{
  pkgs,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;

    settings = lib.mkMerge [
      {
        add_newline = false;
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$directory"
          "$kubernetes"
          "$character"
        ];
        right_format = lib.concatStrings [
          "$git_state"
          "$git_branch"
          "$git_status"
        ];
        username.show_always = false;
        username.format = "[$user]($style) ";
        hostname = {
          disabled = false;
          ssh_only = true;
          format = "@ [$hostname]($style) ";
          style = "blue";
        };

        character.success_symbol = "[❯](purple)";
        character.error_symbol = "[✗](red)";
        directory = {
          style = "blue";
          truncation_length = 5;
          truncate_to_repo = true;
          truncation_symbol = "../";
          read_only = " ";
        };
        git_branch.format = "[$branch]($style) ";
        git_branch.style = "yellow";
        git_status.style = "red";
      }
    ];
  };
}
