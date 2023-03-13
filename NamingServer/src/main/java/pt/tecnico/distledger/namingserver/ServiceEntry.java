public class ServiceEntry {
    
    private String serviceName;
    list<ServerEntry> servers;

    public ServiceEntry() {
        this.serviceName = "DistLedger";
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
