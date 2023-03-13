public class ServerEntry {

    private String host;
    private int port;
    private String qualifier;


    public ServerEntry(String host, int port, String qualifier) {
        this.host = host;
        this.port = port;
        this.qualifier = qualifier;
    }

    public String getHost() {
        return host;
    }

    public int getPort() {
        return port;
    }

    public String getQualifier() {
        return qualifier;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public void setPort(int port) {
        this.port = port;
    }

    public void setQualifier(String qualifier) {
        this.qualifier = qualifier;
    }
}
