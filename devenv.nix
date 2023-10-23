{ pkgs, ... }:

{
  packages = [ pkgs.antlr4 ];

  # Enable for Macos
  # packages = [ pkgs.antlr4 pkgs.cocoapods ];
  # languages.ruby.enable = true;

  #languages.dart.enable = true;
}
