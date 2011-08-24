package codeblockutil;

import java.awt.Cursor;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.swing.JComponent;
import javax.swing.JFileChooser;

public final class CFileHandler {

	public static String readFromFile(JComponent parent){
		JFileChooser filechooser = new JFileChooser("Import Data From");
		filechooser.addChoosableFileFilter(new XMLFilter());
		int returnVal = filechooser.showOpenDialog(parent.getTopLevelAncestor());

                if (returnVal == JFileChooser.APPROVE_OPTION) {
			File file = filechooser.getSelectedFile();
			BufferedReader input = null;
			String line = null;
			if(file != null){
                                try {
					input = new BufferedReader( new FileReader(file) );
                                        if(( line = input.readLine()) != null)
                                            System.out.println("Loaded Project ok");
				}catch (FileNotFoundException ex) {
					ex.printStackTrace();
				}catch (IOException ex){
					ex.printStackTrace();
				}finally{
					try{
						if (input!= null) input.close();
					}catch (IOException ex) {
						ex.printStackTrace();
					}
				}
                                return line;
			}
		}
		return null;
	}

        public static String selectFileToLoad(JComponent parent){
		JFileChooser filechooser = new JFileChooser("Import Data From");
		filechooser.addChoosableFileFilter(new XMLFilter());
                filechooser.setCurrentDirectory(new File("./examples"));
		int returnVal = filechooser.showOpenDialog(parent.getTopLevelAncestor());

                String file = null;

		if (returnVal == JFileChooser.APPROVE_OPTION) {
			file = filechooser.getSelectedFile().getAbsolutePath();
		}
		return file;
	}

	public static boolean writeToFile(JComponent parent, String source){
		JFileChooser fc = new JFileChooser("Saving Data");
                fc.addChoosableFileFilter(new XMLFilter());
		int returnVal = fc.showSaveDialog(parent.getTopLevelAncestor());
		if (returnVal == JFileChooser.APPROVE_OPTION) {
			File f = fc.getSelectedFile();
			//new CProgressBar("Saving Data to " + f.getName());
                        try {
				if(f.getPath().length()>4){
					String extension = f.getPath().substring(f.getPath().length()-4, f.getPath().length());
					if(extension.equals(".xml")){
						System.out.println("Saving with default extension: " + extension);
						//do nothing
					}else{
						System.out.println("Generating extension: " + extension);
						f = new File(f.getPath()+".xml");
					}
				}else{
					System.out.println("Filename too short");
					f = new File(f.getPath()+".xml");
				}
				Writer output = null;
				output = new BufferedWriter( new FileWriter(f) );
				output.write(source);
				output.close();
				return true;
			} catch (IOException io) {
				io.printStackTrace();
				return false;
			}
		}
		return false;
	}

        public static boolean writeToLua(JComponent parent, String source){
            //new CProgressBar("Saving compiled program...");
            try {
            File f = new File("./support/sie_program.lua");
                Writer output = null;
		output = new BufferedWriter( new FileWriter(f) );
		output.write(source);
		output.close();
		return true;
            } catch (IOException io) {
                io.printStackTrace();
		return false;
            }
        }

	public static boolean writeToFile(JComponent parent, BufferedImage image){
		JFileChooser fc = new JFileChooser();
		int returnVal = fc.showSaveDialog(parent.getTopLevelAncestor());
		if (returnVal == JFileChooser.APPROVE_OPTION) {
			File f = fc.getSelectedFile();
			new CProgressBar("Saving Graph to " + f.getName());
			try {
				if(f.getPath().length()>4){
					String extension = f.getPath().substring(f.getPath().length()-4, f.getPath().length());
					String extension2 = f.getPath().substring(f.getPath().length()-5, f.getPath().length());
					if(extension.equals(".jpg") || extension.equals(".gif") || extension.equals(".tif") || 
							extension.equals(".png") || extension2.equals(".jpeg") || extension2.equals(".tiff")){
						System.out.println("Saving with default extension: " + extension);
						//do nothing
					}else{
						System.out.println("Generating extension: " + extension);
						f = new File(f.getPath()+".jpg");
					}
				}else{
					System.out.println("Filename too short");
					f = new File(f.getPath()+".jpg");
				}
				ImageIO.write(image, "jpg", f);
				return true;
			} catch (IOException io) {
				io.printStackTrace();
				return false;
			}
		}
		return false;
	}

        public static boolean writeScriptToFile(JComponent parent, String source){
		JFileChooser fc = new JFileChooser("Saving Data");
		int returnVal = fc.showSaveDialog(parent.getTopLevelAncestor());
		if (returnVal == JFileChooser.APPROVE_OPTION) {
			File f = fc.getSelectedFile();
			new CProgressBar("Saving Data to " + f.getName());
			try {
				if(f.getPath().length()>4){
					String extension = f.getPath().substring(f.getPath().length()-4, f.getPath().length());
					if(extension.equals(".xml")){
						System.out.println("Saving with default extension: " + extension);
						//do nothing
					}else{
						System.out.println("Generating extension: " + extension);
						f = new File(f.getPath()+".xml");
					}
				}else{
					System.out.println("Filename too short");
					f = new File(f.getPath()+".xml");
				}
				Writer output = null;
				output = new BufferedWriter( new FileWriter(f) );
				output.write(source);
				output.close();
				return true;
			} catch (IOException io) {
				io.printStackTrace();
				return false;
			}
		}
		return false;
	}
}
