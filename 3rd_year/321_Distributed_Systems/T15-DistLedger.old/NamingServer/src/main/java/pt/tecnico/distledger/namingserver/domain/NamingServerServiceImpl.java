package pt.tecnico.distledger.namingserver.domain;

import io.grpc.stub.StreamObserver;
import pt.ulisboa.tecnico.distledger.contract.distledgerserver.DistLedgerCrossServerServiceGrpc.DistLedgerCrossServerServiceImplBase;
import pt.ulisboa.tecnico.distledger.contract.namingserver.ServerNamingServer.RegisterRequest;
import pt.ulisboa.tecnico.distledger.contract.namingserver.ServerNamingServer.RegisterResponse;

public class NamingServerServiceImpl extends DistLedgerCrossServerServiceImplBase{
    // implement register method

    // @Override
    public void register(RegisterRequest request, StreamObserver<RegisterResponse> responseObserver) {
        // get the name and the ip from the request
        String name = request.getServerName();
        String qualifier = request.getQualifier();
        String target = request.getTarget();

        //todo: create a new server with the name and the ip
        
        //todo: add the server to the list of servers

        // create a response
        RegisterResponse response = RegisterResponse.newBuilder().build();

        // send the response
        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }
}
