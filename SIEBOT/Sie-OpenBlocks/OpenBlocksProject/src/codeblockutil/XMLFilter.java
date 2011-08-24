package codeblockutil;

import java.io.File;

import javax.swing.filechooser.FileFilter;

public class XMLFilter extends FileFilter {
    public boolean accept(File file) {
    	if(file != null){
    		String filename = file.getName();
    		if (file.isDirectory()){
    			return true;
    		}else if (filename != null){
    			return filename.endsWith(".xml");
    		}
    	}
        return false;
    }
    public String getDescription() {
        return "*.xml";
    }
}
