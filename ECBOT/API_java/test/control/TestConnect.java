/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package control;

import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author solid
 */
public class TestConnect {

    private ControlInstruction control;


    public TestConnect() {
    }
    
    @Test
    public void nullHost(){
        control = new ControlInstruction(null);
        assertEquals(control.connect(), -1);
    }

    @Test
    public void wrongHost(){
        control = new ControlInstruction("wrongHost");
        assertEquals(control.connect(), -1);
    }

    @Test
    public void zeroHost(){
        control = new ControlInstruction("");
        assertEquals(control.connect(), -1);
    }

    @Test
    public void wrongIP(){
        control = new ControlInstruction("192.168.0.100");
        assertEquals(control.connect(),-1);
    }

    @Test
    public void correctHost(){
        control = new ControlInstruction("localhost");
        assertEquals(control.connect(), 0);
    }

    @Test
    public void correctIP(){
        control = new ControlInstruction("127.0.0.1");
        assertEquals(control.connect(), 0);
    }




    

}