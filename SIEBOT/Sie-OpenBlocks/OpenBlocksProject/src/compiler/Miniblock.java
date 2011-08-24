package compiler;

import java.util.ArrayList;
import java.util.Collections;

/**
 * This class is intended for store a simplified version of a codeblock, so it will be
 * more easy to make a Lua-like script
 * @author juanjo
 */
public class Miniblock {

    private final Long blockID;
    private final String genus;
    private final String label;
    private final ArrayList<Long> sockets;
    private final Long plug;
    private final Long before;
    private final Long after;

 /**
 * The constructor will spect for a string with 7 sections divided by a ","
 * @param miniBlock information string
 */

    public Miniblock(String miniBlock){

        String sections[] = miniBlock.split(",");

        blockID = setConnectedId(sections[0]);
        genus = sections[1];
        label = sections[2];
        sockets = parseSockets(sections[3]);
        plug = setConnectedId(sections[4]);
        before = setConnectedId(sections[5]);
        after = setConnectedId(sections[6]);

    }
    
    public Miniblock(Long id, String ge, String la, ArrayList<Long> so, Long pl, Long be, Long af){

        blockID = id;
        genus = ge;
        label = la;
        sockets = so;
        plug = pl;
        before = be;
        after = af;

    }

    public Miniblock cloneMiniblock(Miniblock mb){

        Miniblock copy = new Miniblock(mb.blockID,mb.genus,mb.label,mb.sockets,mb.plug,mb.before,mb.after);

        return copy;
    }

    private ArrayList<Long> parseSockets(String ss){
        int index = 0;
        ArrayList<Long> socketsArray = new ArrayList<Long>();

        String stringArray[] = ss.split(":");

        while(index < stringArray.length){
            socketsArray.add(setConnectedId(stringArray[index]));
            index++;
        }
        
        return socketsArray;
    }

    public String getSaveString(){
        int index = 0;

        StringBuilder buf = new StringBuilder();

        buf.append("MiniBlock->");
        buf.append("id: ").append(this.blockID);
        buf.append(", genus: ").append(this.genus);
        buf.append(", label: ").append(this.label);
        buf.append(", sockets: ");
        for(Long id : getSockets()){
            buf.append(id.toString()).append(":");
        }
        buf.append(", plug: ").append(this.plug);
        buf.append(", before: ").append(this.before);
        buf.append(", after: ").append(this.after);

        return buf.toString();

    }

    private Long setConnectedId(String id){
        if(!id.equals(""))
                return Long.parseLong(id);
        return 0L;
    }

    public Iterable<Long> getSockets(){
        return Collections.unmodifiableList(new ArrayList<Long>(sockets));
    }

    public Long getAfter() {
        return after;
    }

    public Long getBefore() {
        return before;
    }

    public Long getBlockID() {
        return blockID;
    }

    public String getLabel() {
        return label;
    }

    public String getGenus() {
        return genus;
    }

    public Long getPlug() {
        return plug;
    }

}
