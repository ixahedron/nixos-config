{ ... } :

{

  # for Serokell development work
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "ix" ];


  nix.binaryCaches = [
    "https://cache.nixos.org/"
    "https://nixcache.reflex-frp.org"
    "https://s3.eu-west-3.amazonaws.com/tezos-nix-cache"
  ];

  nix.binaryCachePublicKeys = [ "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI=" "obsidian-tezos-kiln:WlSLNxlnEAdYvrwzxmNMTMrheSniCg6O4EhqCHsMvvo=" ];


  # Required for Ledger Live to detect Ledger Nano S via USB
  hardware.ledger.enable = true;

}
