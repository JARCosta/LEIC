package pt.tecnico.distledger.namingserver;

public class NamingServerMain {

    map<String, ServiceEntry> services;

    private static final int port = 5001;

    public static void main(String[] args) {

        /* TODO */
        servers = new HashMap<String, ServiceEntry>();
        NamingServerMain namingServer = new NamingServerMain();

    }

    public void addService(String serviceName) {
        ServiceEntry serviceEntry = new ServiceEntry();
        servers.put(service, serviceEntry);
    }

    public void removeService(String serviceName) {
        servers.remove(service);
    }

    public void addServer(String serviceName, String host, int port, String qualifier) {
        ServerEntry serverEntry = new ServerEntry(host, port, qualifier);
        servers.get(service).addServer(serverEntry);
    }

}
