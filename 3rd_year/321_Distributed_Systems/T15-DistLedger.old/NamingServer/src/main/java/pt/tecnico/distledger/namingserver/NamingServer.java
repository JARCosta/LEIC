package pt.tecnico.distledger.namingserver;
import java.io.IOException;
import java.util.Map;
import java.util.HashMap;

import io.grpc.BindableService;
import io.grpc.Server;
import io.grpc.ServerBuilder;
import pt.tecnico.distledger.namingserver.domain.NamingServerServiceImpl;
import pt.tecnico.distledger.namingserver.domain.ServerEntry;
import pt.tecnico.distledger.namingserver.domain.ServiceEntry;

public class NamingServer {

    private static Map<String, ServiceEntry> services;

    private static final int port = 5001;

    
    public static void main(String[] args) throws IOException, InterruptedException{
        
        /* TODO */
        System.out.printf("Received %d arguments%n", args.length);
		for (int i = 0; i < args.length; i++) {
            System.out.printf("arg[%d] = %s%n", i, args[i]);
		}
        
        services = new HashMap<String, ServiceEntry>();
        
		final BindableService serverService = new NamingServerServiceImpl();
        // NamingServer namingServer = new NamingServer();

        // Create a new server to listen on port
        Server server = ServerBuilder.forPort(port).addService(serverService).build();

		// Start the server
		server.start();

		// Server threads are running in the background.
		System.out.println("Server started");

		// Do not exit the main thread. Wait until server is terminated.
		server.awaitTermination();
    }


    public void addService(String serverName) {
        ServiceEntry serviceEntry = new ServiceEntry();
        services.put("DistLedger", serviceEntry);
    }

    public void removeService(String serviceName) {
        services.remove(serviceName);
    }

    public void addServer(String serviceName, String qualifier, String target) {
        ServerEntry serverEntry = new ServerEntry(qualifier, target);
        services.get(serviceName).addServer(serverEntry);
    }

}
