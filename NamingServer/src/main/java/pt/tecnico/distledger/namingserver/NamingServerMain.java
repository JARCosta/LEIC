package pt.tecnico.distledger.namingserver;
import java.util.*;

public class NamingServerMain {

    private static Map<String, ServiceEntry> services;

    private static final int port = 5001;

    public static void main(String[] args) {

        /* TODO */
        services = new HashMap<String, ServiceEntry>();
        NamingServerMain namingServer = new NamingServerMain();

    }

    public void addService(String serviceName, String serverName) {
        ServiceEntry serviceEntry = new ServiceEntry(serverName);
        services.put(serviceName, serviceEntry);
    }

    public void removeService(String serviceName) {
        services.remove(serviceName);
    }

    public void addServer(String serviceName, String qualifier, String target) {
        ServerEntry serverEntry = new ServerEntry(qualifier, target);
        services.get(serviceName).addServer(serverEntry);
    }

}
