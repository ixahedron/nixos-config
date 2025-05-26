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
  virtualisation.docker.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "ix" ];

  environment.systemPackages = packages;

#  # Yggdrasil
#  services.yggdrasil = {
#    enable = true;
#    persistentKeys = false;
#    openMulticastPort = true;
#
#    settings = {
#      Peers = [
#        # Yggdrasil will automatically connect and "peer" with other nodes it
#        # discovers via link-local multicast announcements. Unless this is the
#        # case (it probably isn't) a node needs peers within the existing
#        # network that it can tunnel to.
#        "tls://78.27.153.163:3784"
#        "tls://193.111.114.28:1443"
#        "tcp://ygg-ukr.incognet.io:8883"
#        "tls://91.224.254.114:18001"
#        "tls://185.165.169.234:8443"
#        "tls://54.37.137.221:11129"
#      ];
#
#      Listen = [
#        "tls://0.0.0.0:6553"
#      ];
#
#      MulticastInterfaces = [{
#        Regex = ".*";
#        Beacon = true;
#        Listen = true;
#        Password = "";
#      }];
#    };
#  };

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
