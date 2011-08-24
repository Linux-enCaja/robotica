/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.util.ArrayList;

/**
 *
 * @author solid
 */
public class LoopInstruction extends Instruction{

    private ArrayList<Instruction> instructions;
    private int iterations;

    public int getIterations() {
        return iterations;

    }

    public void setIterations(int iterations) {
        this.iterations = iterations;
    }
    
    private String command;

   

    public LoopInstruction(){
        super();
    }

    public ArrayList<Instruction> getInstructions() {
        return instructions;
    }

    public void setInstructions(ArrayList<Instruction> instructions) {
        this.instructions = instructions;
    }   

    

}
