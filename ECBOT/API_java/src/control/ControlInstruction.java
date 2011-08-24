
package control;


import boundary.SocketClient;
import entity.Instruction;
import entity.LoopInstruction;
import java.io.IOException;
import java.util.ArrayList;

/**
 *<code> ControlInstruction </code> controls communication between PrincipalFrame and
 * Ecbot using a client-server design
 *
 * <p>
 * Set and validate a List of  Instruction and sends it to SocketClient
 *
 * @author solid
 */
public class ControlInstruction {

    private SocketClient client;
    private String host;
    
    /**
     * @param host The host address of ecbot
     *Initialize a ControlInstruction instance
     */
    public ControlInstruction(String host) {
        this.host = host;
        client = new SocketClient(host);
    }

    public String getHost() {
        return host;
    }

    /**
     *  <p>
     * Creates a socket connection with ecbot's server
     * using the ecbot entity information
     *
     * @return result  in a int value.
     * @throws IOException
     */
    public int connect() {
        return client.connect();
    }

    /**
     * Close the connection with the server ...
     * @return a int value. 0 on success , -1 on Error..
     */
    public int close(){
        return client.close();

    }

    
    
    public int execute(ArrayList<Instruction> inst){
        if (inst == null)
            return -1;
        else{
            int message = 0;
            for (Instruction x: inst){
                if(x.getCommand() == null || x.getCommand().equals(""))
                    return -1;
                if (x.getClass().equals(LoopInstruction.class))
                    loopExecute((LoopInstruction)x);
                else{                    
                    message += x.getCommand().length();                    
                    if (client.send(x.getCommand()) == -1)
                        return -1;
                }
            }            
            return 0;
        }
    }
    /**
     * <p>Convert all instructions in line instructions
     */
    

    public int read(){
        return client.read();
    }

    private void loopExecute(LoopInstruction x) {
        for (int i = 0; i < x.getIterations(); i++){
            execute(x.getInstructions());
        }
    }
}


