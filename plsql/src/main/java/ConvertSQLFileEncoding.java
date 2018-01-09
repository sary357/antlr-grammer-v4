import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

/**
 * 
 */

/**
 * @author fuming.tsai
 *
 */
public class ConvertSQLFileEncoding {
    public static void convertFilesInFolder(String sourcePath, String sourceFileEncoding, String destinationPath, String destinationFileEncoding) throws Exception{
        File sourceFolder=new File(sourcePath);
       // File destinationFolder=new File(destinationPath);
        if (sourceFolder.isDirectory()){
          //  sourceFolder.get
            String[] l=sourceFolder.list();
            for(String s: l){
                File tmpFile=new File(sourcePath+"/"+s);
                if (tmpFile.isDirectory()){
                    File destinationFolder=new File(destinationPath+"/"+s);
                    if(!destinationFolder.exists())
                        destinationFolder.mkdir();
                    convertFilesInFolder(sourcePath+"/"+s,   sourceFileEncoding, destinationPath+"/"+s, destinationFileEncoding);
                }else if(tmpFile.isFile()){
                    convertSOLFileEncoding(sourcePath+"/"+s,   sourceFileEncoding, destinationPath+"/"+s, destinationFileEncoding);
                }
            }
        }else if(sourceFolder.isFile()){
            convertSOLFileEncoding(sourcePath,sourceFileEncoding, destinationPath, destinationFileEncoding );
        }
    }
    
    public static void convertSOLFileEncoding(String sourceFile, String sourceFileEncoding, String destinationFile, String destinationFileEncoding) throws Exception{
        if(sourceFile.endsWith(".SQL") || sourceFile.endsWith(".sql")){
            BufferedReader br = new BufferedReader(
              //  new InputStreamReader(new FileInputStream("D:\\temp\\Dimensions\\BNK_D_WMG\\DM\\DM_WMG\\SP_KPI_CUST_LOCATION_WORK.SQL"), "Big5"));    
                    new InputStreamReader(new FileInputStream(sourceFile), sourceFileEncoding));
        
                // new InputStreamReader(new ByteArrayInputStream(str.getBytes(), "Big5"));
            PrintWriter pw = new PrintWriter(
                new OutputStreamWriter(new FileOutputStream(destinationFile),destinationFileEncoding));
            String line = br.readLine();
            while (line != null) {
               // System.out.println(line);
                pw.write(line+"\r\n");
                line = br.readLine();
            }
            pw.flush();
            pw.close();
            br.close();
        }
    }
    
//    public static String getFileListName(String path){      
//        File f=new File(path);
//        if(f.isFile()){
//            if(f.getAbsolutePath().endsWith(".sql") || f.getAbsolutePath().endsWith(".SQL"))
//                return f.getAbsolutePath();
//            else
//                return null;
//        } else{
//            String[] l=f.list();
//            String tmp="";
//            for(String s:l){
//                if(getFileListName(path+"/"+s)!=null)
//                    tmp=tmp+"\n"+getFileListName(path+"/"+s);
//            }
//            return tmp;
//        }           
//    }
    public static void main(String[] args) throws Exception 
    {
        String inputFilePath=args[0];
        String inputFileEncoding=args[1];
        String outputFilePath=args[2];
        String outputFileEncoding=args[3];
        
        
//        BufferedReader br = new BufferedReader(
//          //  new InputStreamReader(new FileInputStream("D:\\temp\\Dimensions\\BNK_D_WMG\\DM\\DM_WMG\\SP_KPI_CUST_LOCATION_WORK.SQL"), "Big5"));    
//                new InputStreamReader(new FileInputStream("D:\\temp\\SP_KPI_CUST_LOCATION_WORK.SQL"), "Big5"));
//
//            // new InputStreamReader(new ByteArrayInputStream(str.getBytes(), "Big5"));
//        PrintWriter pw = new PrintWriter(
//            new OutputStreamWriter(new FileOutputStream("D:\\temp\\SP_KPI_CUST_LOCATION_WORK-1.SQL"), "UTF8"));
//        String line = br.readLine();
//        while (line != null) {
//           // System.out.println(line);
//            pw.write(line+"\n");
//            line = br.readLine();
//        }
//        pw.flush();
//        pw.close();
        System.out.println("---------------------- Start --------------------");
        System.out.println("---------------------- Processing....... --------------------");
        ConvertSQLFileEncoding.convertFilesInFolder(inputFilePath,inputFileEncoding ,outputFilePath,outputFileEncoding);
        System.out.println("----------------------  End  --------------------");
     //   D:\temp\Dimension-2
    }

}
