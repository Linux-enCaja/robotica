/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import control.ControlInstruction;
import java.util.ArrayList;

/**
 *
 * @author laarguelless
 */
public class Ecbot implements Runnable{

    private String name;
    private ControlInstruction  control;
    private ArrayList<Instruction> instructions;

    public Ecbot(String name, ControlInstruction control){
        this.name = name;
        this.control = control;
        this.instructions = new ArrayList<Instruction>();
    }

    public ControlInstruction getControl() {
        return control;
    }

    public void setControl(ControlInstruction control) {
        this.control = control;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setInstructions(ArrayList<Instruction> instructions){
        this.instructions = instructions;
    }

    public void run() {
        try{
        control.connect();
        control.execute(instructions);
        }catch(Exception exc){
            System.out.println("Error en la ejecucion");
        }
        finally{
            control.close();
        }
    }

}
