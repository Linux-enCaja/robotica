/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package control;

import codeblocks.BlockConnector;
import controller.WorkspaceController;
import entity.Ecbot;
import entity.Instruction;
import entity.LoopInstruction;
import java.util.ArrayList;
import renderable.RenderableBlock;
import workspace.Page;
import workspace.Workspace;


/**
 *
 * @author laarguelless
 */
public class BlocksControl extends WorkspaceController{

    private BlockInterpreter interpreter;
    private Workspace workspc;

    public BlocksControl(){
        super();
        this.workspc = BlocksControl.workspace;
        interpreter = new BlockInterpreter();
    }

    public void run(ConnectionManager manager){
        //Manejo de bloques para convertirlos en instrucciones con sentido...
        ArrayList<Instruction> instructions = new ArrayList<Instruction>();
        ArrayList<Page> pages = (ArrayList<Page>) BlocksControl.workspace.getBlockCanvas().getPages();
        for (Page page: pages){
            RenderableBlock temp;
            ArrayList<RenderableBlock> topBlocks = (ArrayList<RenderableBlock>) page.getTopLevelBlocks();
            ArrayList<RenderableBlock> allBlocks = (ArrayList<RenderableBlock>) page.getBlocks();
            for (RenderableBlock block: topBlocks){
               temp = block;
               instructions = generateStack(block, topBlocks, allBlocks);
               Ecbot bot =  manager.getConnection(page.getPageName());
               bot.setInstructions(instructions);
               bot.run();
            }           
            //Limpia el buffer de instrucciones ...
            instructions.clear();
        }
    }  

    private ArrayList<RenderableBlock> getArguments(Iterable<BlockConnector> sockets, ArrayList<RenderableBlock> blocks) {
        ArrayList<RenderableBlock> result = new ArrayList<RenderableBlock>();
        long id;
        RenderableBlock block;
        for ( BlockConnector connector: sockets){
            id = connector.getBlockID();
            block = getRenderableBlock(blocks, id);
            result.add(block);
        }
        return result;
    }

    private RenderableBlock getRenderableBlock(ArrayList<RenderableBlock> blocks, long id) {
        RenderableBlock block = null;
        for (RenderableBlock bl:blocks){
            if (bl.getBlockID() == id)
                block = bl;
        }
        return block;
    }

    public void addPage(String name, int size) {
        if (size == 1){
           getWorkspace().getBlockCanvas().getPageNamed("Disconnect").setPageName(name);
        }       
    }

    public Workspace getWorkspace(){
        return this.workspc;
    }
    private ArrayList<Instruction> generateStack(RenderableBlock block, ArrayList<RenderableBlock> topBlocks, ArrayList<RenderableBlock> allBlocks){
        RenderableBlock temp;
        ArrayList<Instruction> instructions = new ArrayList<Instruction>();
        temp = block;
        while (temp != null && temp.getBlock().hasAfterConnector()){
                    if (temp.getBlock().isCommandBlock()){
                        if(temp.getKeyword().equals("repeat")){
                            ArrayList<RenderableBlock> arguments = getArguments(temp.getBlock().getSockets(), allBlocks);
                            LoopInstruction loop = interpreter.getIterationInstruction(temp,arguments);
                            loop.setInstructions(generateStack(arguments.get(1), topBlocks, allBlocks));
                            instructions.add(loop);
                        }
                        else{
                            instructions.add(interpreter.getCommandInstruction(temp,
                            getArguments(temp.getBlock().getSockets(), allBlocks)));
                        }                    
                    temp = getRenderableBlock(allBlocks, temp.getBlock().getAfterBlockID());
                    }
                }
        return instructions;
    }
}
