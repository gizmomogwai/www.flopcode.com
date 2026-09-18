{ pkgs, ... }:

{
  languages.ruby = {
    enable = true;
    version = "4.0.7";
  };

  enterShell = ''
    bundle install
  '';
}
