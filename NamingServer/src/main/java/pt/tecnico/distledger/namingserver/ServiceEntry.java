package pt.tecnico.distledger.namingserver;
import java.util.*;


public class ServiceEntry {
    
    private String serviceName;
    List<ServerEntry> servers;

    public ServiceEntry(String serverName) {
        this.serviceName = serverName;
        this.servers = new ArrayList<ServerEntry>();
    }

    public void addServer(ServerEntry server) {
        servers.add(server);
    }

    public void setServers(List<ServerEntry> servers) {
        this.servers = servers;
    }

    public void removeServer(ServerEntry server) {
        servers.remove(server);
    }

    public List<ServerEntry> getServers() {
        return servers;
    }



}
