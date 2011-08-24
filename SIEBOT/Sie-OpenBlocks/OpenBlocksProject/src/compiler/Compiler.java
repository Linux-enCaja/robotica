package compiler;

import java.util.ArrayList;
import java.util.Collections;

/**
 *
 * @author Juan José Díaz Vecchio
 */
public class Compiler {

    private final ArrayList<Miniblock> miniBlockList;
    private final String FOREVER_MISSING = "forever_missing";
    private StringBuilder compiledProgram = new StringBuilder();

/**
 * The constructor will spect for a big string with many lines as blocks in the codeblocks page,
 * each one ending with ";"
 * @param page (program) information string
 */

    public Compiler(String stringToCompile){

        //System.out.print(stringToCompile);
        miniBlockList = getSourceArray(stringToCompile);

    }

    public String doCompiling(){
        boolean thereIsSetup = false;

        //Search for the setup block
        Miniblock mb = searchByGenus("setup");
        // if mb==null then is no setup block
        if(mb != null){
            //Initiate program writing with the "setup" block ("function setup()" in Lua)
            compilerMachine(mb);
            //advise of setup block existence
            thereIsSetup = true;
        }
        
        //Continue with the "forever" block ("function forever()" in Lua)
        mb = searchByGenus("forever");
        // At least a "forever" block is needed
        if(mb != null){
            compilerMachine(mb);
        }else {
            return FOREVER_MISSING;
        }

        //OK!!! everythong is compiled, now add a "main" function for the final Lua script
        addMain(thereIsSetup);

        //return the compiled script
        return compiledProgram.toString();
    }

    private ArrayList<Miniblock> getSourceArray(String ss){

        ArrayList<Miniblock> miniBArray = new ArrayList<Miniblock>();
        int index = 0;

        String stringArray[] = ss.split(";\n");

        while(index < stringArray.length){
            Miniblock MB = new Miniblock(stringArray[index]);
            miniBArray.add(MB);
            index++;
        }

        return miniBArray;
    }

    public String getSaveString(){

        StringBuilder buf = new StringBuilder();

        //retrieve save strings of miniblockblocks within this Program
        for(Miniblock mb : getMiniblocks()){
            buf.append(mb.getSaveString()).append("\n");
        }

        return buf.toString();

    }

    private Iterable<Miniblock> getMiniblocks(){
        return Collections.unmodifiableList(new ArrayList<Miniblock>(miniBlockList));
    }

    private Miniblock searchById(Long id){
        //retrieve the miniblockblock with matching ID, or null if not found
        for(Miniblock mb : getMiniblocks()){
            if(mb.getBlockID().equals(id))
                return mb;
        }
        return null;
    }

    private Miniblock searchByGenus(String ge){
        //retrieve the miniblockblock with matching genus, or null if not found
        for(Miniblock mb : getMiniblocks()){
            if(mb.getGenus().equals(ge))
                return mb;
        }
        return null;
    }

    private Miniblock searchByPlug(Long pl){
        //retrieve the miniblockblock with matching plug, or null if not found
        for(Miniblock mb : getMiniblocks()){
            if(mb.getPlug().equals(pl))
                return mb;
        }
        return null;
    }

    private void compilerMachine(Miniblock mb){
        System.out.print(mb.getGenus());
        
        if(mb.getGenus().equals("variable"))
        {
            //call variable getter function
            variable(mb);
        }

        else if(mb.getGenus().equals("constant"))
        {
            //call constant function
            constant(mb);
        }

        else if(mb.getGenus().equals("move"))
        {
            //call move function without turn argument
            move(mb,false);
        }

        else if(mb.getGenus().equals("justMoveFor"))
        {
            //call justMove function without backward argument
            justMove(mb,false);
        }

        else if(mb.getGenus().equals("justMoveBack"))
        {
            //call justMove function with backward argument
            justMove(mb,true);
        }

        else if(mb.getGenus().equals("turn"))
        {
            //call move function with turn argument
            move(mb,true);
        }

        else if(mb.getGenus().equals("data"))
        {
            //call data initializer function
            data(mb);
        }

        else if(mb.getGenus().equals("for"))
        {
            //call for function
            forLoop(mb);
        }

        else if(mb.getGenus().equals("while"))
        {
            //call for function
            whileLoop(mb);
        }

        else if(mb.getGenus().equals("delayMs"))
        {
            //call delayMs function
            delayMs(mb);
        }

        else if(mb.getGenus().equals("pwm"))
        {
            //call pwm function
            pwm(mb);
        }

        else if(mb.getGenus().equals("print"))
        {
            //call print function
            print(mb);
        }

        else if(mb.getGenus().equals("clear"))
        {
            //call clear function
            clear(mb);
        }

        else if(mb.getGenus().equals("rencoder"))
        {
            //call right enconder function
            rencoder(mb);
        }

        else if(mb.getGenus().equals("lencoder"))
        {
            //call left encoder function
            lencoder(mb);
        }

        else if(mb.getGenus().equals("inc"))
        {
            //call increment function
            inc(mb);
        }

        else if(mb.getGenus().equals("sum"))
        {
            //call sum function
            sum(mb);
        }

        else if(mb.getGenus().equals("difference"))
        {
            //call difference function
            difference(mb);
        }

        else if(mb.getGenus().equals("product"))
        {
            //call product function
            product(mb);
        }

        else if(mb.getGenus().equals("quotient"))
        {
            //call quotient function
            quotient(mb);
        }

        else if(mb.getGenus().equals("equals"))
        {
            //call equals function
            equals(mb);
        }

        else if(mb.getGenus().equals("not-equals"))
        {
            //call not equals function
            notequals(mb);
        }

        else if(mb.getGenus().equals("lessthan"))
        {
            //call lessthan function
            lessthan(mb);
        }

        else if(mb.getGenus().equals("lessthanorequalto"))
        {
            //call lessthan or equal to function
            lessthanorequalto(mb);
        }

        else if(mb.getGenus().equals("greaterthan"))
        {
            //call greaterthan function
            greaterthan(mb);
        }

        else if(mb.getGenus().equals("greaterthanorequalto"))
        {
            //call greaterthan or equal to function
            greaterthanorequalto(mb);
        }

        else if(mb.getGenus().equals("if"))
        {
            //call print function
            ifCondition(mb);
        }

        else if(mb.getGenus().equals("ifelse"))
        {
            //call print function
            ifElseCondition(mb);
        }

        else if(mb.getGenus().equals("or"))
        {
            //call print function
            or(mb);
        }

        else if(mb.getGenus().equals("and"))
        {
            //call print function
            and(mb);
        }

        else if(mb.getGenus().equals("not"))
        {
            //call print function
            not(mb);
        }

        else if(mb.getGenus().equals("true"))
        {
            //call print function
            constant(mb);
        }

        else if(mb.getGenus().equals("false"))
        {
            //call print function
            constant(mb);
        }

        else if(mb.getGenus().equals("setupGpio"))
        {
            //call setupGpio function
            setupGpio(mb);
        }

        else if(mb.getGenus().equals("gps-lat"))
        {
            //call setupGpio function
            gps(0);
        }

        else if(mb.getGenus().equals("gps-lon"))
        {
            //call setupGpio function
            gps(1);
        }

        else if(mb.getGenus().equals("gps-time"))
        {
            //call setupGpio function
            gps(2);
        }

        else if(mb.getGenus().equals("stop"))
        {
            //call move function without turn argument
            stop(mb);
        }

        /*else if(mb.getGenus().equals("???"))
        {
            //call setupGpio function
            ???(mb);
        }*/

        else if(mb.getGenus().equals("return"))
        {
            //call forever function
            finish(mb);
        }

        else if(mb.getGenus().equals("forever"))
        {
            //call forever function
            forever(mb);
        }

        else if(mb.getGenus().equals("setup"))
        {
            //call setup function
            setup(mb);
        }
    }

    /*Add a main function for the final Lua script, this is a code that
         * calls the setup() function in Lua at first time, and then calls
         * the forever() function inside a while loop that reapeats over and
         * over again.
        */

    private void addMain(boolean setup){
        
        if(setup)
            compiledProgram.append("setup()\n");
        compiledProgram.append("repeat\n"
                + "forever()\n"
                + "until false\n");
    }

    private void setup(Miniblock mb){
        compiledProgram.append("function setup()\n");
            for(Long so : mb.getSockets()){
                compilerMachine(searchById(so));
            }
            compiledProgram.append("end\n\n");
    }

    private void forever(Miniblock mb){
        compiledProgram.append("function forever()\n");
        for(Long so : mb.getSockets()){
            compilerMachine(searchById(so));
        }
        compiledProgram.append("end\n\n");
    }

    private void setupGpio(Miniblock mb){
        //init setupGpio
        compiledProgram.append("sie_Llib.setupGpio(");
        //add arguments
        for(Long so : mb.getSockets()){
            compiledProgram.append(searchById(so).getGenus()).append(",");
        }
        //delete the last "," and the "dig" part of the first argument, then close de function
        compiledProgram.deleteCharAt(compiledProgram.lastIndexOf(","));
        compiledProgram.delete(compiledProgram.indexOf("dig"),compiledProgram.indexOf("dig")+3);
        compiledProgram.append(")\n");
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void forLoop(Miniblock mb){
        Integer index = 0;
            //init for
            compiledProgram.append("for ");
            for(Long so : mb.getSockets()){
                compilerMachine(searchById(so));
                if(index.equals(2))compiledProgram.append(" do\n");
                else if(index.equals(3))compiledProgram.append("end\n");
                else compiledProgram.append(", ");
                index++;
            }
            // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
            if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void whileLoop(Miniblock mb){
        Integer index = 0;
            //init for
            compiledProgram.append("while ");
            for(Long so : mb.getSockets()){
                compilerMachine(searchById(so));
                if(index.equals(0))compiledProgram.append(" do\n");
                index++;
            }
            compiledProgram.append("end\n");
            // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
            if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void ifCondition(Miniblock mb){
        Integer index = 0;
            //init for
            compiledProgram.append("if ");
            for(Long so : mb.getSockets()){
                compilerMachine(searchById(so));
                if(index.equals(0))compiledProgram.append(" then\n");
                index++;
            }
            compiledProgram.append("end\n");
            // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
            if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void ifElseCondition(Miniblock mb){
        Integer index = 0;
            //init for
            compiledProgram.append("if ");
            for(Long so : mb.getSockets()){
                compilerMachine(searchById(so));
                if(index.equals(0))compiledProgram.append(" then\n");
                if(index.equals(1))compiledProgram.append(" else\n");
                index++;
            }
            compiledProgram.append("end\n");
            // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
            if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void data(Miniblock mb){
        compiledProgram.append(mb.getLabel()).append(" = ");
        for(Long so : mb.getSockets()){
            compilerMachine(searchById(so));
        }
        // This line search the before block, if it's a forLoop block, doesn't add "\n"
        if(!searchById(mb.getBefore()).getGenus().equals("for"))compiledProgram.append("\n");
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void constant(Miniblock mb){
        compiledProgram.append(mb.getLabel());
    }

    private void pwm(Miniblock mb){
        Integer index = 0;
        //init pwm
        compiledProgram.append("sie_Llib.pwm(");
        //add arguments
        for(Long so : mb.getSockets()){
            if(index.equals(0))compiledProgram.append(searchById(so).getGenus()).append(",math.floor(");
            else compilerMachine(searchById(so));
            index++;
        }
        //delete the "dig" part of the first argument
        compiledProgram.delete(compiledProgram.indexOf("dig"),compiledProgram.indexOf("dig")+3);
        //convert from 0% - 100% to 0 - 255, then close de function
        compiledProgram.append("*2.55))\n");
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void move(Miniblock mb,boolean turn){
        // Busy wait movement, this is a combination of move+while(encoder...)
        Integer index = 0;
        Integer speed = 0;
        boolean back = false;
        compiledProgram.append("sie_Llib.restart_enc()\n");
        compiledProgram.append("sie_Llib.move(");
        //add arguments for movement
        for(Long so : mb.getSockets()){
            if(index.equals(0)){        // set the action code of the movement
                                        // 1- move forward; 2- move backward
                if(searchById(so).getGenus().matches("forward"))
                    compiledProgram.append("1,math.floor((");
                else if(searchById(so).getGenus().matches("backward")){
                    compiledProgram.append("2,math.floor((");
                    back = true;
                }
                else if(searchById(so).getGenus().matches("right"))
                    compiledProgram.append("3,math.floor((");
                else if(searchById(so).getGenus().matches("left"))
                    compiledProgram.append("4,math.floor((");
            }
            else if(index.equals(1)){   // set the speed of the movement (pwm)
                speed = Integer.parseInt(searchById(so).getLabel());
                //convert from 0% - 100% to 0 - 255, then close de function
                compiledProgram.append(speed).append("*1.27)+128))\n");
            }
            else if(index.equals(2)){
                // while loop to drive the stop of the motor
                if(!turn){
                    // Right now, the robot doesn't have encoders so let's make
                    // a timer to drive the stop
                    
                    // If the movement is forward or backward, the steps drives the stop
//                    compiledProgram.append("repeat\n");
//                    compiledProgram.append("sie_Llib.delayMs(200)\n");
//                    compiledProgram.append("enc = sie_Llib.encoder(0)\n");
//                    if(!back)compiledProgram.append("until enc > ");
//                    else compiledProgram.append("until sie_Llib.encoder(0) < -");
//                    compilerMachine(searchById(so));
                    
                    // based on the turn code on the "else" block below:
                    compiledProgram.append("sie_Llib.delayMs(math.floor(");
                    compilerMachine(searchById(so)); // get the steps count
                    compiledProgram.append("/").append(speed); //divide the steps by the speed
                    compiledProgram.append("*3600/0.2))");  // kind of 3 seconds for "25 steps"
                                                            // this is like 30cm... jst an estimation
                                                            // for the white robot.
                }else{
                    // If the movement is right or left, the time and the speed drives the stop
                    // the time needed to complete the turn meets the ecuation:
                    // X=(T/0.9)*(N/n); where
                    // T -> time spent to turn 90° at 100% speed in miliseconds
                    //      (this time needs to be measured, it's a robot caracteristic "constant")
                    //      for now let's asume T = 3600 ms
                    // N -> angle to turn (degrees)
                    // n -> speed to perform the turn (0-100)
                    compiledProgram.append("sie_Llib.delayMs(math.floor(");
                    compilerMachine(searchById(so)); // get the angle
                    compiledProgram.append("/").append(speed); //divide the angle by the speed
                    compiledProgram.append("*3600/0.9))");
                }
                compiledProgram.append("\nsie_Llib.move(0,0)\n");
            }
            index++;
        }

        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void justMove(Miniblock mb,boolean back){
        // movement just activate de motors at max speed
        if(back)compiledProgram.append("sie_Llib.move(2,255)\n");
        else compiledProgram.append("sie_Llib.move(1,255)\n");

        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void variable(Miniblock mb){
        compiledProgram.append(mb.getLabel());
    }

    private void rencoder(Miniblock mb){
        compiledProgram.append("sie_Llib.encoder(0)");
    }

    private void lencoder(Miniblock mb){
        compiledProgram.append("sie_Llib.encoder(1)");
    }

    private void gps(int req){
        compiledProgram.append("sie_Llib.gps(").append(req).append(")/1000000");
    }

    private void clear(Miniblock mb){
        compiledProgram.append("sie_Llib.clear()\n");
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void finish(Miniblock mb){
        compiledProgram.append("sie_Llib.terminate()\n");
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void delayMs(Miniblock mb){
        //init delayMs
        boolean first = true;
        compiledProgram.append("sie_Llib.delayMs(");
        for(Long so : mb.getSockets()){
            if(!first){
                compiledProgram.append(",");
                if(searchById(so).getLabel().equals("true"))compiledProgram.append("1");
                else compiledProgram.append("0");
            }else compilerMachine(searchById(so));
            first = false;
        }
        compiledProgram.append(")\n");
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void stop(Miniblock mb){
        //init delayMs
        compiledProgram.append("sie_Llib.move(0)\n");
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void print(Miniblock mb){
        //init print
        boolean first = true;
        compiledProgram.append("sie_Llib.message(");
        for(Long so : mb.getSockets()){
            if(!first)compiledProgram.append(",");
            compilerMachine(searchById(so));
            first = false;
        }
        compiledProgram.append(")\n");
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void inc(Miniblock mb){
        boolean second = false;
        for(Long so : mb.getSockets()){
            if(!second){
                compilerMachine(searchById(so));
                second = true;
            }else {
                compiledProgram.append(" = ");
                compilerMachine(searchById(so));
            }
            compiledProgram.append(" + 1\n");
        }
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void sum(Miniblock mb){
        boolean second = false;
        for(Long so : mb.getSockets()){
            if(!second){
                compilerMachine(searchById(so));
                second = true;
            }else {
                compiledProgram.append(" + ");
                compilerMachine(searchById(so));
            }
        }
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void and(Miniblock mb){
        boolean second = false;
        for(Long so : mb.getSockets()){
            if(!second){
                compilerMachine(searchById(so));
                second = true;
            }else {
                compiledProgram.append(" and ");
                compilerMachine(searchById(so));
            }
        }
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void or(Miniblock mb){
        boolean second = false;
        for(Long so : mb.getSockets()){
            if(!second){
                compilerMachine(searchById(so));
                second = true;
            }else {
                compiledProgram.append(" or ");
                compilerMachine(searchById(so));
            }
        }
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void not(Miniblock mb){
        //init print
        compiledProgram.append("not(");
        for(Long so : mb.getSockets()){
            compilerMachine(searchById(so));
        }
        compiledProgram.append(")\n");
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void difference(Miniblock mb){
        boolean second = false;
        for(Long so : mb.getSockets()){
            if(!second){
                compilerMachine(searchById(so));
                second = true;
            }else {
                compiledProgram.append(" - ");
                compilerMachine(searchById(so));
            }
        }
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void product(Miniblock mb){
        boolean second = false;
        for(Long so : mb.getSockets()){
            if(!second){
                compilerMachine(searchById(so));
                second = true;
            }else {
                compiledProgram.append(" * ");
                compilerMachine(searchById(so));
            }
        }
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void quotient(Miniblock mb){
        boolean second = false;
        for(Long so : mb.getSockets()){
            if(!second){
                compilerMachine(searchById(so));
                second = true;
            }else {
                compiledProgram.append(" / ");
                compilerMachine(searchById(so));
            }
        }
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void equals(Miniblock mb){
        boolean second = false;
        for(Long so : mb.getSockets()){
            if(!second){
                compilerMachine(searchById(so));
                second = true;
            }else {
                compiledProgram.append(" == ");
                compilerMachine(searchById(so));
            }
        }
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void notequals(Miniblock mb){
        boolean second = false;
        for(Long so : mb.getSockets()){
            if(!second){
                compilerMachine(searchById(so));
                second = true;
            }else {
                compiledProgram.append(" ~= ");
                compilerMachine(searchById(so));
            }
        }
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void lessthan(Miniblock mb){
        boolean second = false;
        for(Long so : mb.getSockets()){
            if(!second){
                compilerMachine(searchById(so));
                second = true;
            }else {
                compiledProgram.append(" < ");
                compilerMachine(searchById(so));
            }
        }
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void lessthanorequalto(Miniblock mb){
        boolean second = false;
        for(Long so : mb.getSockets()){
            if(!second){
                compilerMachine(searchById(so));
                second = true;
            }else {
                compiledProgram.append(" <= ");
                compilerMachine(searchById(so));
            }
        }
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void greaterthan(Miniblock mb){
        boolean second = false;
        for(Long so : mb.getSockets()){
            if(!second){
                compilerMachine(searchById(so));
                second = true;
            }else {
                compiledProgram.append(" > ");
                compilerMachine(searchById(so));
            }
        }
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

    private void greaterthanorequalto(Miniblock mb){
        boolean second = false;
        for(Long so : mb.getSockets()){
            if(!second){
                compilerMachine(searchById(so));
                second = true;
            }else {
                compiledProgram.append(" >= ");
                compilerMachine(searchById(so));
            }
        }
        // IMPORTANT!!!: every block of "command" kind must have this line after the line feed
        if(!mb.getAfter().equals(0L))compilerMachine(searchById(mb.getAfter()));
    }

}
