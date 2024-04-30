{pkgs, ...}: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      show-failed-attempts = true;
      hide-keyboard-layout = true;
      screenshots = true;
      effect-blur = "20x3";
      # disabled until; https://github.com/jirutka/swaylock-effects/issues/25
      # fade-in = 0.1;

      indicator-caps-lock = true;
      indicator-radius = 120;
      indicator-thickness = 10;

      font = "Inter";
      font-size = 15;

      key-hl-color = "A3BE8C";
      caps-lock-key-hl-color = "62AEEF";
      bs-hl-color = "BF616A";
      caps-lock-bs-hl-color = "BF616A";

      inside-color = "00000000";
      inside-clear-color = "00000000";
      inside-caps-lock-color = "00000000";
      inside-ver-color = "62AEEF";
      inside-wrong-color = "BF616A";

      layout-bg-color = "81A1C1";
      layout-border-color = "81A1C1";
      layout-text-color = "2E3440";

      line-color = "2E3440";
      line-clear-color = "BF616A";
      line-caps-lock-color = "2E3440";
      line-ver-color = "2E3440";
      line-wrong-color = "2E3440";

      ring-color = "81A1C1";
      ring-clear-color = "2E3440";
      ring-caps-lock-color = "B48EAD";
      ring-ver-color = "62AEEF";
      ring-wrong-color = "BF616A";

      separator-color = "2E3440";

      text-color = "ECEFF4";
      text-clear-color = "ECEFF4";
      text-caps-lock-color = "ECEFF4";
      text-ver-color = "2E3440";
      text-wrong-color = "2E3440";
    };
  };
}
