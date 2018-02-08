import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.Writer;
import java.nio.charset.Charset;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.fubon.data.Node;
import com.fubon.data.NodeManager;

public class ExcelInfoExtracter {
    public static final int SOURCE_TABLE_OWNER_FIELD=12;
    public static final int SOURCE_TABLE_FIELD=13;
    public static final int SOURCE_TABLE_TYPE_FIELD=14;
    
    public static final int TARGET_TABLE_OWNER_FIELD=2;
    public static final int TARGET_TABLE_FIELD=3;
    public static final int TARGET_TABLE_TYPE_FIELD=4;
    
    public static final int SHEET_NUM=1;
    
    public static final String TYPE_STR="able";
    
    public static Set<String> getSourceTableTargetTablePair(String filePath){
        if(filePath.endsWith(".xls"))
            return getSourceTableTargetTablePairFromXls(filePath);
        else if(filePath.endsWith(".xlsx"))
            return getSourceTableTargetTablePairFromXlsx(filePath);
        else
            return null;
    }
    
    public static Set<String> getSourceTableTargetTablePairFromXlsx(String sqlPath){
        Set<String> result=new HashSet<String>();
        File f=new File(sqlPath);
        FileInputStream fis ; 
        POIFSFileSystem fs ; 
        XSSFWorkbook  wb ; 
        //XSSFWorkbook wbXlxs;
        String fileName=f.getName();
        try{
            fis = new FileInputStream(sqlPath); 
            //fs = new POIFSFileSystem( fis ); 
            wb = new XSSFWorkbook(fis); 
            XSSFSheet sheet = wb.getSheetAt(SHEET_NUM);  

            XSSFCell sourceTypeCell, targetTypeCell, sourceOwnerCell, sourceTableCell, targetOwnerCell, targetTableCell; 

            for (int i = 2; i < sheet.getPhysicalNumberOfRows() ; i++) {  
               XSSFRow row = sheet.getRow(i); 
                if(row!=null){ 
                    
                     sourceTypeCell = row.getCell(SOURCE_TABLE_TYPE_FIELD); 
                     targetTypeCell= row.getCell(TARGET_TABLE_FIELD); 
                     sourceOwnerCell=row.getCell(SOURCE_TABLE_OWNER_FIELD);
                     sourceTableCell=row.getCell(SOURCE_TABLE_FIELD);
                     targetOwnerCell=row.getCell(TARGET_TABLE_OWNER_FIELD);
                     targetTableCell=row.getCell(TARGET_TABLE_FIELD);
                     if(sourceTypeCell!=null && 
                         sourceTypeCell.toString().length()>0 &&
                             targetTypeCell!=null &&  
                                 targetTypeCell.toString().length() >0 &&
                                     sourceTableCell!=null && 
                                         sourceTableCell.toString().length()>0 &&
                                             targetTableCell!=null && 
                                                 targetTableCell.toString().length()>0
                                             ){
                         result.add(sourceOwnerCell.toString().toUpperCase()+"."+sourceTableCell.toString().toUpperCase()+","+targetOwnerCell.toString().toUpperCase()+"."+targetTableCell.toString().toUpperCase());
                         
                     }
                                    
                     
                } 
             
            } 

             fis.close();//
        }catch(java.io.IOException e) 
        { 
            e.printStackTrace(); 
        } 
        
        return result;
    }
    
    public static Set<String> getSourceTableTargetTablePairFromXls(String sqlPath){
        Set<String> result=new HashSet<String>();
        File f=new File(sqlPath);
        FileInputStream fis ; 
        POIFSFileSystem fs ; 
        HSSFWorkbook wb ; 
        //XSSFWorkbook wbXlxs;
        String fileName=f.getName();
        try{
            fis = new FileInputStream(sqlPath); 
            fs = new POIFSFileSystem( fis ); 
            wb = new HSSFWorkbook(fs); 
            HSSFSheet sheet = wb.getSheetAt(SHEET_NUM);  

            HSSFCell sourceTypeCell, targetTypeCell, sourceOwnerCell, sourceTableCell, targetOwnerCell, targetTableCell; 

            for (int i = 2; i < sheet.getPhysicalNumberOfRows() ; i++) {  
                HSSFRow row = sheet.getRow(i); 
                if(row!=null){ 
                    
                     sourceTypeCell = row.getCell(SOURCE_TABLE_TYPE_FIELD); 
                     targetTypeCell= row.getCell(TARGET_TABLE_FIELD); 
                     sourceOwnerCell=row.getCell(SOURCE_TABLE_OWNER_FIELD);
                     sourceTableCell=row.getCell(SOURCE_TABLE_FIELD);
                     targetOwnerCell=row.getCell(TARGET_TABLE_OWNER_FIELD);
                     targetTableCell=row.getCell(TARGET_TABLE_FIELD);
                     if(sourceTypeCell!=null && 
                         sourceTypeCell.toString().length()>0 &&
                             targetTypeCell!=null &&  
                                 targetTypeCell.toString().length() >0 &&
                                     sourceTableCell!=null && 
                                         sourceTableCell.toString().length()>0 &&
                                             targetTableCell!=null && 
                                                 targetTableCell.toString().length()>0
                                             ){
                         if(sourceOwnerCell!=null && targetOwnerCell!=null)
                             result.add(sourceOwnerCell.toString().toUpperCase()+"."+sourceTableCell.toString().toUpperCase()+","+targetOwnerCell.toString().toUpperCase()+"."+targetTableCell.toString().toUpperCase());
                         if(sourceOwnerCell==null && targetOwnerCell!=null)
                             result.add(sourceTableCell.toString().toUpperCase()+","+targetOwnerCell.toString().toUpperCase()+"."+targetTableCell.toString().toUpperCase());
                         if(sourceOwnerCell!=null && targetOwnerCell==null)
                             result.add(sourceOwnerCell.toString().toUpperCase()+"."+sourceTableCell.toString().toUpperCase()+","+targetTableCell.toString().toUpperCase());
                         if(sourceOwnerCell==null && targetOwnerCell==null)
                             result.add(sourceTableCell.toString().toUpperCase()+","+targetTableCell.toString().toUpperCase());
                          
                        
                     }
                                    
                     
                } 
             
            } 

             fis.close();//
        }catch(java.io.IOException e) 
        { 
            e.printStackTrace(); 
        } 
        
        return result;
    }
    
    public static void outputTableSet(String sqlPath, Set<String> tableSet, Writer outputWriter) throws IOException{
        File f=new File(sqlPath);
        Node parentNode, childNode;
        NodeManager nmgr=new NodeManager();
        String fileName=f.getName();
        List<String> sortList=new ArrayList<String>(tableSet);
        Collections.sort(sortList);
        for(String s: sortList){
            String [] tmpArr=s.split(",");
            parentNode=new Node(tmpArr[0]);
            childNode=new Node(tmpArr[1]);
            //System.out.println(fileName+","+s);
            nmgr.addNodeRelation(parentNode, childNode);
        }
        //System.out.println("--------------------");
        String[] result=nmgr.toString().split("\n");
       // BufferedWriter w=getWriter(outputPath);
        outputWriter.write("EXCEL_FILE_NAME,SOURCE_TABLE,TARGET_TABLE");
        for(String s: result){
            outputWriter.write(fileName+","+s+"\n");
            //System.out.println(fileName+","+s);
        }
       // w.flush();
       // w.close();
    }
    
    public static BufferedWriter getWriter(String path) throws IOException{
        Path p= FileSystems.getDefault().getPath(path);
        Charset charset = Charset.forName("UTF-8");
        BufferedWriter writer=null;
        try  {
            writer = Files.newBufferedWriter(p, charset);
        } catch (IOException x) {
            System.err.format("IOException: %s%n", x);
            throw x;
        }
        return writer;
    }
    
    public static String getFileListName(String path){      
        File f=new File(path);
        if(f.isFile()){
            if(f.getAbsolutePath().endsWith(".xls") || f.getAbsolutePath().endsWith(".xlsx") )
                return f.getAbsolutePath();
            else{
                //System.out.println(f.getAbsolutePath());
                return null;
            }
        } else{
            String[] l=f.list();
            String tmp="";
            for(String s:l){
                if(getFileListName(path+"/"+s)!=null)
                    tmp=tmp+"\n"+getFileListName(path+"/"+s);
            }
            return tmp;
        }           
    }
    
    @SuppressWarnings("deprecation")
    public static void main(String[] args) throws Exception{
        //String fileName="D:/資料分析應用科/暫存區/血緣分析表資料/tmp/血緣分析表/血緣分析表/M1/DM_CFRISK/DM_CFRISK.SP_D_CFRISK_CCSUM_CE_EXE_程式規格書-附件_KEVIN_20170915V1.xls";
        //String fileName="D:/temp/test.xls";
        if(args.length!=2){
            System.err.println("Missing necessary arguments \n");
            System.out.println("Parameters:java ExcelInfoExtracter EXCEL_PATH RESULT_FILE_PATH");
            
            System.exit(1);;
        }
        String inputPath=args[0];//"D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/c1.sql";
        String outputPath=args[1]; // write csv in reportFile
        System.out.println("Input Excel Path: " + inputPath);
        System.out.println("Output File Path: " + outputPath);
        //inputPath="D:/資料分析應用科/暫存區/血緣分析表資料/tmp/血緣分析表/血緣分析表/M1 redo/DM_CFRISK/M1_DM_CFRISK.SP_D_CFRISK_LM002_B_352_879.xls" ;
        
        File inputFile=new File(inputPath);
        Writer w=getWriter(outputPath);
        if(inputFile.isFile()){
            System.out.println("Processing file: "+inputPath);
            Set<String> tableSet=getSourceTableTargetTablePair(inputPath);
            outputTableSet(inputPath, tableSet, w);
            
        }else if (inputFile.isDirectory()){
            String [] resultPath=getFileListName(inputPath).split("\n");
            for(String inFilePath: resultPath){
                if(inFilePath!=null && inFilePath.length()>0){
                    System.out.println("Processing file: "+inFilePath);
                    Set<String> tableSet=getSourceTableTargetTablePair(inFilePath);
                    outputTableSet(inFilePath, tableSet, w);
                }
            }
        }
        w.flush();
        w.close();
        System.out.println("Done");
        
        /**
         * production: D:/資料分析應用科/暫存區/血緣分析表資料/tmp/血緣分析表/血緣分析表   D:/資料分析應用科/暫存區/血緣分析表資料/tmp/血緣分析表/血緣分析表/report.csv
         * 
         * dev: D:/資料分析應用科/暫存區/血緣分析表資料/tmp/血緣分析表/血緣分析表/M1/DM_CFRISK/DM_CFRISK.SP_D_CFRISK_CCSUM_CE_EXE_程式規格書-附件_KEVIN_20170915V1.xls   D:/資料分析應用科/暫存區/血緣分析表資料/tmp/血緣分析表/血緣分析表/report.csv
         */
        
    }
}
