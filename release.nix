{ nix-pills ? { outPath = ./.; revCount = 1234; shortRev = "abcdef"; }
, nixpkgs ? { outPath = <nixpkgs>; revCount = 1234; shortRev = "abcdef"; }
, officialRelease ? false
}:

let
  pkgs = import <nixpkgs> { };
in rec {
  pills = import ./default.nix {
    inherit pkgs;

    inherit (nix-pills) revCount shortRev;
  };

  release = pkgs.releaseTools.aggregate
    { name = "nix-pills-release";
      constituents =
        [
          pills.html-split
          pills.epub
        ];
      meta.description = "All build outputs";
    };
}
