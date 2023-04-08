{ pkgs, ... }:

{
  packages = [ pkgs.antlr4 ];

  languages.dart.enable = true;
}
