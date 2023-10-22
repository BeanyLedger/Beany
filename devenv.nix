{ pkgs, ... }:

{
  packages = [ pkgs.antlr4 pkgs.cocoapods ];

  #languages.dart.enable = true;
  languages.ruby.enable = true;
}
