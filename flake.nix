{
  description = "https://github.com/NixOS/nixpkgs/issues/264687";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/59e7944d2a7d49264525dd6d9a91a3d86b0f0526";
  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      crossSystem = {
        config = "aarch64-unknown-linux-musl";
        rustc.config = "aarch64-unknown-linux-musl";
        isStatic = true;
      };
    };
  in {
    packages.x86_64-linux.default = pkgs.rustPlatform.buildRustPackage {
      name = "nixpkgs-issue-264687-example";
      version = "0.0";
      src = ./.;
      cargoLock.lockFile = ./Cargo.lock;
      auditable = false;
      RUSTFLAGS = [
        # "-Clinker=lld"
        # "-Clinker-flavor=ld.lld"
        # "-Ctarget-feature=+crt-static"
      ];
      nativeBuildInputs = with pkgs; [
        pkg-config
        # llvmPackages.lld
      ];
      buildInputs = with pkgs; [
        openssl
      ];
    };
  };
}
