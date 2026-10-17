{
  description = "clojure-code";
  outputs = inputs @ {self, ...}:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} (top @ {
      config,
      withSystem,
      moduleWithSystem,
      ...
    }: let
      flakeModules = inputs.idr.lib.importFlakeModules ./nix top;
    in {
      idr.projectName = "clojure-code";
      flake.modules.flake = flakeModules;
      imports = (inputs.nixpkgs.lib.attrValues flakeModules) ++ [inputs.idr.modules.flake.idr];
      systems = import inputs.systems;
    });
  inputs = {
    nixpkgs.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-26.05";
    nixpkgs-unstable.url = "git+https://github.com/NixOS/nixpkgs?shallow=1&ref=nixos-unstable";
    flake-parts.url = "git+https://github.com/hercules-ci/flake-parts?shallow=1";
    systems.url = "git+https://github.com/nix-systems/default?shallow=1";
    team = {
      url = "file+file:///dev/null";
      flake = false;
    };
    idr = {
      url = "git+https://github.com/idr-nix/idr?shallow=1";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
        systems.follows = "systems";
        team.follows = "team";
      };
    };
  };
}
