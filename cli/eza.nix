{ ... }:
{
  programs.eza.enable = true;
  programs.eza.extraOptions = [
    "--group-directories-first"
    "--git"
  ];
}
