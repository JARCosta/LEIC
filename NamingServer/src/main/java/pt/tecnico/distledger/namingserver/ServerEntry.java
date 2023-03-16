package pt.tecnico.distledger.namingserver;
public class ServerEntry {

    private String qualifier;
    private String target;


    public ServerEntry(String qualifier, String target){
        this.qualifier = qualifier;
        this.target = target;
    }

    public String getQualifier() {
        return qualifier;
    }
    
    public String getTarget() {
        return target;
    }
    
    public void setQualifier(String qualifier) {
        this.qualifier = qualifier;
    }
    
    public void setTarget(String address) {
        this.target = target;
    }


    
}
