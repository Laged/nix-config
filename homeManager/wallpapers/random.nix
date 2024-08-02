{ pkgs ? import <nixpkgs> { } }:

let
  directory = "./";
  files = builtins.attrNames (builtins.readDir directory);
  jpgFiles = pkgs.lib.filter (file: pkgs.lib.strings.hasSuffix ".jpg" file) files;

  # Generate a pseudo-random index based on a fixed seed
  pseudoRandomIndex = seed: (builtins.hashString "sha256" (toString seed)) % builtins.length jpgFiles;

  # Fixed seed for demonstration (change to get different results)
  randomIndex = pseudoRandomIndex 12345;

  # Handle empty list case
  selectedJpgFile = if builtins.length jpgFiles > 0 then builtins.elemAt jpgFiles randomIndex else "No .jpg files found";
in
"${directory}/${selectedJpgFile}"

