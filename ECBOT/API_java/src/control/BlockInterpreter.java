/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package control;

import entity.Instruction;
import entity.LoopInstruction;
import java.util.ArrayList;
import java.util.Random;
import renderable.RenderableBlock;

/**
 *
 * @author solid
 */
public class BlockInterpreter {

    public BlockInterpreter(){
    }

    public Instruction getCommandInstruction(RenderableBlock command, ArrayList<RenderableBlock> arguments){
                
        Instruction instruction = new Instruction();
        String str = convertToCommand(command.getKeyword());
        for (RenderableBlock block: arguments)
            str += " "+ block.getKeyword();
        instruction.setCommand(str);
        return instruction;
        
        
    }

    public LoopInstruction getIterationInstruction(RenderableBlock command, ArrayList<RenderableBlock> arguments){
        LoopInstruction loop = new LoopInstruction();
        loop.setCommand(command.getKeyword());
        loop.setIterations(Integer.parseInt(arguments.get(0).getKeyword()));
        return loop;
    }

    private String convertToCommand(String keyword){
        if(keyword.equals("forward"))
            return "movefw";
        else if(keyword.equals("back"))
            return "movebk";
        else if(keyword.equals("left"))
            return "movelf";
        else if(keyword.equals("right"))
            return "moverg";        
        else if (keyword.equals("random color"))
            return randomColor();
        else
            return keyword;
    }

    private String randomColor() {
        Random rnd = new Random(System.currentTimeMillis());
        String res = "color "+ rnd.nextInt(10);
        System.out.println(res);
        return res;
    }

}
