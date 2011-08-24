/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package control;

import entity.Ecbot;
import java.util.ArrayList;

/**
 *
 * @author solid
 */
public class ConnectionManager {

    private ArrayList<Ecbot> connections;

    public ConnectionManager() {
        connections = new ArrayList<Ecbot>();
    }

    public void addConnection(Ecbot ecbot) {
        connections.add(ecbot);
    }

    public void removeConnection(String name){
        Ecbot temp = null;
        for (Ecbot bot: this.connections){
            if(bot.getName().equals(name))
                temp = bot;
        }
        connections.remove(temp);
    }

    public int isConnectionValid(Ecbot ecbot){
       for(Ecbot bot: connections){
            if (bot.getName().equals(ecbot.getName()))
                return -1;
            if (bot.getControl().getHost().equals(ecbot.getControl().getHost()))
                return -2;
        }
        return 0;
    }

    public ArrayList<Ecbot> getConnections() {
        return connections;
    }

    public boolean noConnections() {
        return connections.isEmpty();
    } 

    Ecbot getConnection(String pageName) {
        for (Ecbot bot: connections){
            if(bot.getName().equals(pageName))
                return bot;
        }
        return null;
    }






}
