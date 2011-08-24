
package boundary;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;

/**
 *@author laarguelless
 *@version 0.2
 * 
 */
public class SocketClient {

    private String host;
    private Socket socket;
    private static final int PORT = 5000;
    private DataOutputStream out;
    private BufferedReader in;


    /**
     *
     * @param h The host address
     */
    public SocketClient(String h){
        host = h;
    }

    /**
     * Try to open connection with the server and creates
     * a DataOutputStream instance with the socket OutputStream
     *
     * @return a int value of the result. 0 on success, -1 on Error
     */
    public int connect() {        
        if (!validateHost())
            return -1;
        
        try{
        socket = new Socket(host, PORT);  
        out = new DataOutputStream(socket.getOutputStream());
        in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        }catch(Exception e){
            return -1;
        }
        return 0;
    }

    /**
     * Validate type and length of host
     * @return a value type with the reusult
     */
    private boolean validateHost(){
        if(host == null || host.length() == 0)
            return false;
        return true;
    }

    /**
     * <p/>
     * Close the connection
     * @return a int value with the result. 0 on success or -1 on IOException.
     * @throws IOException     *
     */
    public int close(){
        try{
        socket.close();
        }catch(IOException e){
            return -1;
        }
        return 0;
    }

    /**
     * Sends a string message to the server
     * @param message A String message
     * @return int value with the result. 0 on success or -1 on IOException.
     */
    public int send(String message){

        try{
        out.flush();
        out.writeBytes(message);
       
        }catch(IOException e){
            return -1;
        }



        return 0;
    }

    public int read(){
        String x;
        try {
            x= in.readLine();
            System.out.println(x);            
        } catch (IOException ex) {
            return -1;
        }
        return 0;
    }   

}
