/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package control;

import entity.Instruction;
import java.util.ArrayList;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author laarguelless
 */
public class TestExecute {

   private ControlInstruction control;
   private ArrayList<Instruction> instructions = new ArrayList<Instruction>();


   @Before
   public void before(){

       control = new ControlInstruction("localhost");
       control.connect();
   }

   @After
   public void after(){
       control.close();
   }

   @Test
   public void nullInstructions(){
        instructions = null;        
        assertEquals(control.execute(instructions), -1);
   }

   @Test
   public void noInstruction(){       
        Instruction ins= new Instruction();
        instructions.add(ins);        
        assertEquals(control.execute(instructions), -1);
   }

  


   

   @Test
   public void correctInstructions(){
        
        Instruction ins1 = new Instruction();
        ins1.setCommand("color 0");
        
        Instruction ins2 = new Instruction();
        ins2.setCommand("color 1");
        
        Instruction ins3  = new Instruction();
        ins3.setCommand("color 7");
        
        instructions.add(ins1); 
        instructions.add(ins2);
        instructions.add(ins3);        
        assertEquals(control.execute(instructions), 0);
        

   }

}