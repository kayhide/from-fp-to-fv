{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs:
    let
      overlay = final: prev: { };

      perSystem = system:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ overlay ];
          };

          dev-env = pkgs.buildEnv {
            name = "dev-env";
            paths = with pkgs; [
              nodejs-18_x
            ];
          };
        in
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              dev-env
            ];
          };
        };
    in

    {
      inherit overlay;
    } // inputs.flake-utils.lib.eachDefaultSystem perSystem;
}
