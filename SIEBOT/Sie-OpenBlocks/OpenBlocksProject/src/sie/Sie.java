package sie;

/**
 *
 * @author juanjo
 */

import controller.WorkspaceController;
import java.net.*;
import java.io.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import net.schmizz.sshj.SSHClient;
import net.schmizz.sshj.connection.channel.direct.Session;
import net.schmizz.sshj.connection.channel.direct.Session.Command;

public class Sie {

  public void connect(){
    //System.out.println("Connecting with sie...");
    //Get up de interface USB0
    try{
        Runtime.getRuntime().exec("gksu ifconfig usb0 192.168.254.100 up");
    }catch (IOException ex) {
        Logger.getLogger(WorkspaceController.class.getName()).log(Level.SEVERE, null, ex);
    }
  }

  public void reboot(){
    try {
        //System.out.println("Rebooting sie...");
        //reboot Sie trough ssh
        ssh_command("/sbin/reboot");
    } catch (IOException ex) {
        Logger.getLogger(Sie.class.getName()).log(Level.SEVERE, null, ex);
    }
  }

  public void stopActualProgram(){
    try {
        //System.out.println("Stoping any actual program...");
        //Kill any "sie_lua" process and reset de FPGA
        ssh_command("~/connected pause; ~/stop_lua");
    } catch (IOException ex) {
        Logger.getLogger(Sie.class.getName()).log(Level.SEVERE, null, ex);
    }
  }

  public void lcdOn(){
    
    try {
        //System.out.println("Turning on the lcd...");
        //poweron Sie lcd trough ssh
        ssh_command("echo 0 > /sys/devices/platform/jz4740-fb/graphics/fb0/blank");
    } catch (IOException ex) {
        Logger.getLogger(Sie.class.getName()).log(Level.SEVERE, null, ex);
    }
  }
  
  public void uploadAndCompile()throws IOException, ClassNotFoundException {

    // First, copy the "sie_program.lua" script to de sie in ~/ trough scp
    final SSHClient ssh = new SSHClient();
        File knownHostsFile = new File("./support/known_hosts");
        ssh.loadKnownHosts(knownHostsFile);

        ssh.connect("192.168.254.101");
        
    try {
        ssh.authPassword("root", "sie");

        // JZlib must be in classpath for this to work
        ssh.useCompression();

        ssh.newSCPFileTransfer().upload("./support/sie_program.lua", "/root/");
    } finally {
        ssh.disconnect();
    }

    // then compile the script with luac inside of sie
    ssh_command("luac -o sie_program sie_program.lua");
    
  }

  public void runLua(){

    try {
        //System.out.println("Running the script inside Sie...");
        //execute sie_lua program trough ssh, with /dev/tty1 as output screen
        //ssh_command("~/SIECar -qws -nomouse &"); THIS IS THE OLD STYLE
        ssh_command("~/connected play sie_program");
    } catch (IOException ex) {
        Logger.getLogger(Sie.class.getName()).log(Level.SEVERE, null, ex);
    }
  }

  public boolean pingSie () {
    boolean reachable = false;

    //System.out.println("Doing ping to Sie...");
    try {
       InetAddress address = InetAddress.getByName("192.168.254.101");
       //System.out.println("Name: " + address.getHostName());
       //System.out.println("Addr: " + address.getHostAddress());
       //System.out.println("Reach: " + address.isReachable(3000));

       if(reachable = address.isReachable(3000) &&
               ssh_command("/root/connected ping").contains("success"))
               //System.out.println("Sie is reachable");
               //System.out.println(ssh_command("connected ping"));
               reachable = true;
           
       
    }
    catch (UnknownHostException e) {
       System.err.println("Unable to lookup 192.168.254.101");
    }
    catch (IOException e) {
       System.err.println("Unable to reach 192.168.254.101");
    }

    return reachable;

  }

  public String ssh_command(String command)throws IOException{

    final SSHClient ssh = new SSHClient();
    File knownHostsFile = new File("./support/known_hosts");
    ssh.loadKnownHosts(knownHostsFile);

    ssh.connect("192.168.254.101");
    ssh.authPassword("root", "sie");
    Session session = ssh.startSession();
    try{
        try {
            final Command cmd = session.exec(command);
            String out = cmd.getOutputAsString();
            System.out.print(out);
            return out;
            //System.out.println("\n** exit status: " + cmd.getExitStatus());
        } finally {
            session.close();
        }
      }finally {
          ssh.disconnect();
      }
        
  }
}
