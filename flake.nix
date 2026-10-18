
{
  description = "Vagrant development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;

            config.allowUnfreePredicate = pkg:
              nixpkgs.lib.getName pkg == "vagrant";
          };
        in
        {
          default = pkgs.mkShell {
            packages = [ pkgs.vagrant ];

            shellHook = ''
              export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="0"
              export VAGRANT_DEFAULT_PROVIDER="virtualbox"

              # Use the system VirtualBox installation.
              export PATH="/usr/bin:/bin:$PATH"

              echo "Vagrant: $(command -v vagrant)"
              echo "VirtualBox: $(command -v VBoxManage)"
              vagrant --version
              VBoxManage --version
            '';
          };
        });
    };
}
