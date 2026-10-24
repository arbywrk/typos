{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
  };

  outputs =
    inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          # node
          nodejs_26
          # rust
          rustc
          rust-analyzer
          rustfmt
          clippy
          cargo
          # typst
          typst
          tinymist
          # other
          pkg-config
          libsoup_3
          atk
          pango
          cairo
          gdk-pixbuf
          gtk3
          webkitgtk_4_1
          adwaita-icon-theme
        ];

        shellHook = ''
          export XDG_DATA_DIRS="${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:$XDG_DATA_DIRS"
          export GDK_PIXBUF_MODULE_FILE="$(echo ${pkgs.librsvg}/lib/gdk-pixbuf-2.0/*/loaders.cache)"
        '';
      };
    };
}
