{ ... } :
{ pkgs, ... } :

let
  packages = with pkgs; [
    #vscode.fhs
    code-cursor-fhs
    claude-code
  ];

in


{

  # for GEOSurge development work
  # virtualisation.docker.enable = true;

  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "ix" ];

  environment.systemPackages = packages;

  # Postgres
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;

    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       ix       trust
      local all       postgres trust
    '';

    identMap = ''
	    # ArbitraryMapName systemUser DBUser
		  superuser_map      ix        postgres
		  superuser_map      root      postgres
		  superuser_map      postgres  postgres
      # Let other names login as themselves
      superuser_map      /^(.*)$   \1
    '';
  };

}
