/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package boundary;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import javax.swing.JOptionPane;

/**
 *
 * @author solid
 */
public class SaveLoadManager {

    private File file;
    private BufferedWriter writer;
    private BufferedReader reader;

    //private PrincipalFrame parent;



    public SaveLoadManager(File file){
       this.file = file;
    }

    public void saveFile(String content ){
        try{
            writer = new BufferedWriter(new FileWriter(file));
            writer.write(content);
            writer.close();
        }catch(FileNotFoundException exc){

        }catch(IOException excp){
        }
    }

    String loadFile() {
       String content = "";
       String temp;
       try{
          reader = new BufferedReader(new FileReader(file));
          temp = reader.readLine();
          while(temp != null){
              content += temp;
              temp = reader.readLine();
          }
          content +=reader.readLine();
       }catch(IOException exc){

       }
       return content;
    }
}
