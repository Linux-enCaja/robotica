/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package entity;

import java.io.Serializable;
import java.util.ArrayList;
import renderable.RenderableBlock;

/**
 *
 * @author solid
 */
public class Rutine implements Serializable {

    private ArrayList<RenderableBlock> blocks;

    public Rutine() {
        blocks = new ArrayList<RenderableBlock>();
    }

    public ArrayList<RenderableBlock> getBlocks() {
        return blocks;
    }

    public void setBlocks(ArrayList<RenderableBlock> blocks) {
        this.blocks = blocks;
    }

}
