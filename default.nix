let
  pinnedPkgs =
    import (builtins.fetchTarball {
      # Descriptive name to make the store path easier to identify
      name = "nixos-unstable-2018-02-08";
      # Commit hash for nixos-unstable as of 2018-01-06
      url = https://github.com/nixos/nixpkgs/archive/749c0a9c16e4ab6cee82884e949eb9fac93f6261.tar.gz;
      # Hash obtained using `nix-prefetch-url --unpack <url>`
      sha256 = "1p2ybixkfj99pshpk7f8lyk8wcjr274smxn4grlg4jhzbpx92pw6";
    }) {};
in
{ pkgs ? pinnedPkgs }:

with pkgs;

let
in
stdenv.mkDerivation {
  name = "test-environment";
  buildInputs = [ nix emscripten mruby ];
}

