

package boundary;

import control.BlocksControl;
import control.ConnectionManager;
import entity.Ecbot;
import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.util.ArrayList;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import renderable.RenderableBlock;
import workspace.Page;
import workspace.SearchBar;
import workspace.SearchableContainer;

/**
 *
 * @author solid
 */
public class PrincipalFrame extends JFrame{

    private JPanel topPanel;
    private SearchBar searchBar;
    private JButton runB;
    private JButton connectB;
    private JButton saveB;
    private JButton loadB;
    private JButton disconnectB;
    private BlocksControl blockControl;
    private ConnectFrame connectFr;
    private DisconnectFrame disconnectFr;
    private final String langPath = "support/language_def.xml";
    private ConnectionManager connectionManager;

    public PrincipalFrame(){       

        blockControl = new BlocksControl();
        connectionManager = new ConnectionManager();
        try{
            blockControl.setLangDefFilePath(langPath);
            blockControl.loadFreshWorkspace();
        }catch(Exception ex){
            System.out.println("Error accediendo a la configuracion inicial");
        }

    }
    public void init(){

        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setBounds(10, 10,1280,720);
        setTitle("Ecbot");
        setName("Ecbot");

        searchBar = new SearchBar("Search blocks", "Search for blocks in the drawers and workspace", blockControl.getWorkspacePanel());
        for(SearchableContainer con : blockControl.getAllSearchableContainers()){
            searchBar.addSearchableContainer(con);
        }

        connectB = new JButton("Connect");
        connectB.addActionListener(new java.awt.event.ActionListener() {

            public void actionPerformed(ActionEvent evt) {
                connectBActionPerformed(evt);
            }
        });

        disconnectB = new JButton("Disconnect");
        disconnectB.addActionListener(new java.awt.event.ActionListener() {

            public void actionPerformed(ActionEvent evt) {
                disconnectActionPerformed(evt);
            }
        });

        disconnectB.setEnabled(false);
        

        runB = new JButton(new ImageIcon("images/run.png"));
        runB.setSize(25, 25);
        runB.setEnabled(false);
        runB.addActionListener(new java.awt.event.ActionListener(){
            public void actionPerformed(java.awt.event.ActionEvent evt){
                runBActionPerformed(evt);
            }
        });

        saveB = new JButton("Save");
        saveB.addActionListener(new java.awt.event.ActionListener() {

            public void actionPerformed(ActionEvent evt) {
                saveActionPerformed(evt);
            }
        });

        loadB = new JButton("Load");
        loadB.addActionListener(new java.awt.event.ActionListener() {

            public void actionPerformed(ActionEvent evt) {
                loadActionPerformed(evt);
            }
        });

        topPanel = new JPanel();
        searchBar.getComponent().setPreferredSize(new Dimension(130, 23));
        topPanel.add(connectB);
        topPanel.add(disconnectB);
        topPanel.add(searchBar.getComponent());
        topPanel.add(runB);
        topPanel.add(saveB);
        //topPanel.add(loadB);

        add(topPanel, BorderLayout.PAGE_START);
        add(blockControl.getWorkspacePanel(),BorderLayout.CENTER);
        setVisible(true);
    }

    //Button Action Methods....

    private void runBActionPerformed(java.awt.event.ActionEvent evt){
       // Aqui ocurre la magia...
        blockControl.run(connectionManager);
    }

     private void connectBActionPerformed(ActionEvent evt) {
         connectFr = new ConnectFrame(this);
         connectFr.setVisible(true);
         setEnabled(false);
     }

     private void disconnectActionPerformed(ActionEvent evt) {
         disconnectFr = new DisconnectFrame(this);
         disconnectFr.setVisible(true);
         setEnabled(false);
     }

     private void saveActionPerformed(ActionEvent evt) {
                String content = getSaveContent();
                if (content.equals("")|| content == null){
                    JOptionPane.showMessageDialog(this, "Arrastre la rutina que desea guardar a Save", "Error", JOptionPane.ERROR_MESSAGE);
                }
                else{
                    JFileChooser fc = new JFileChooser();
                    int selection = fc.showSaveDialog(this);

                    if(selection == JFileChooser.APPROVE_OPTION){
                        SaveLoadManager manager = new SaveLoadManager(fc.getSelectedFile());
                        manager.saveFile(content);
                    }
                }
                
            }

      private void loadActionPerformed(ActionEvent evt) {
                // Not implemented...
            }

     /// Other Methods....
     private void addPage(String name){
         try{                
             blockControl.getWorkspace().addPage(new Page(name),(int) LEFT_ALIGNMENT);
         }catch(Exception ex){
            JOptionPane.showMessageDialog(this, "Ha ocurrido un error al crear la pagina", "Error", JOptionPane.ERROR_MESSAGE);
         }
         
     }
     
     private void removePage(String name) {
         try{
            blockControl.getWorkspace().removePage(blockControl.getWorkspace().getPageNamed(name));            
         }catch(Exception ex){
            JOptionPane.showMessageDialog(this, "Ha ocurrido un error al borrar la pagina", "Error", JOptionPane.ERROR_MESSAGE);
         }
    }

     public int validateConnection(Ecbot ecbot){
         return this.connectionManager.isConnectionValid(ecbot);
     }

    void addConnection(Ecbot ecbot) {
        if(ecbot != null){
            connectionManager.addConnection(ecbot);
            addPage(ecbot.getName());
            //Activate disconnect button;
            if(!disconnectB.isEnabled()){
                disconnectB.setEnabled(true);
                runB.setEnabled(true);
            }
        }
    }  

    void removeConnection(String name){
           this.connectionManager.removeConnection(name);
           removePage(name);
           //If no connections desactivate disconnect button;
           if(connectionManager.noConnections()){
               disconnectB.setEnabled(false);
               runB.setEnabled(false);
        }
    }

    public ArrayList<Ecbot> getConnections(){
        return connectionManager.getConnections();
    }

    private String getSaveContent() {
        String content = "";
        Page page = blockControl.getWorkspace().getPageNamed("Save");
        for(RenderableBlock block: page.getBlocks()){
            content += block.getSaveString()+"\n";
        }
        return content;
    }

    private void setLoadBlocks(String content) {
        Page page = blockControl.getWorkspace().getPageNamed("Load");
        
        
    }

    

}
