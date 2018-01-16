/**
 * 
 */

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.tree.*;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.io.Reader;
import java.nio.charset.Charset;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;
import java.util.Stack;
import org.neo4j.driver.v1.*;
import static org.neo4j.driver.v1.Values.parameters;
import java.nio.charset.StandardCharsets;
/**
 * after executing this class, you will get the relationship between tables in Neo4j. However, the relationship between column and tables will not exist in this class.
 * 
 */
public class PlsqlTableScanner extends PlSqlParserBaseListener{
    private PlSqlParser parser;
  
    public static final String DESTINATION="[destination:insert][delete target:delete][update target table:update][merge into destination table: merge]"; // destination
    public static final String SOURCE="[source:insert][delete source table:delete][update source table: update][merge source table: merge]"; // source
    public static final String CSV_FILE_FIELDS="SQL_FILE_NAME,SOURCE_TABLE,TARGET_TABLE";
    public static final String UTF_8="UTF-8";
    private Stack<String> tableStack=new Stack<String>();
    private Stack<String> statusStack=new Stack<String>();
    private Stack<String> tmpTableStack=new Stack<String>();
    private boolean isInCursorDeclaration=false;
    private boolean inLoop=false;
    
    private Map<String,List<String>> cursorQueryTable=new HashMap<String, List<String>>(); // key=cursor_name, value=table1,table2,...,etc
    private String tempCursorName=null;
    private Set<String> processingCursorNames=new HashSet<String>();
    private Map<String, Set<String>> tableList=null; // key: owner.table  value(a set): column
    private Set<String> tableList2=new HashSet<String>(); // table name only
    private boolean initialized=false;
    private String sqlFileName;
    BufferedWriter bfw;
  //  private String neo4jHost;
 //   private String neo4jUsername;
 //   private String neo4jPassword;
    
    private Map<String, Set<String>> tableAlias=new HashMap<String,Set<String>>(); // key: alias, value: table name
//    public PlsqlTableRelationParser(PlSqlParser parser){
//        this.parser=parser;
//    }   
    
    public PlsqlTableScanner(PlSqlParser parser, BufferedWriter w,String sqlFile, String[] tableListFileName){
        this.parser=parser;
        this.bfw=w;   
        File f=new File(sqlFile);
        this.sqlFileName=f.getName();
        this.ingestTableList(tableListFileName);
    }  
    
    private void ingestTableList(String[] fileName){
        // format: owner_name,table_name,column_name
        String line;
        BufferedReader in;
        tableList=new HashMap<String, Set<String>>();
        Set<String> tmpSet;
        String tableName;
        String columnName;
        try{
            for(String f: fileName){
                // System.out.println("Read content from file: "+f);
                
                in = new BufferedReader(new FileReader(f));
                while((line=in.readLine()) != null)
                {
                      // System.out.println(line);
                       String[] tmpStrArr=line.split(",");
                       if(tmpStrArr.length==3){
                           tableName=tmpStrArr[0].trim().toUpperCase()+"."+tmpStrArr[1].trim().toUpperCase();
                           columnName=tmpStrArr[2];
//                           if(tableName.indexOf("WMG_VD_FLAG_WORK_201308BL")>=0){
//                               System.out.println(columnName);
//                           }
                           tableList2.add(tmpStrArr[1].trim().toUpperCase());
                           tmpSet=tableList.get(tableName);
                           if(tmpSet==null){
                               tmpSet=new HashSet<String>();                             
                           }
                           tmpSet.add(columnName);
                           tableList.put(tableName, tmpSet);
                           
                       }                       
                }
               // System.out.println(line);
            }
            initialized=true;
        }catch(Exception e){
            e.printStackTrace();          
            initialized=false;
        }
       
    }
    
    public boolean isInitialized(){
        return this.initialized;
    }
    private void printStackInfo(String sqlType){
        boolean sourceExist=false;
        boolean destinationExist=false;
        List<String> tmpList;
        Set<String> upperStreamTableName=new HashSet<String>();
        String downStreamTableName=null;//=new HashSet<String>();
        String tmpStr;
        if(tableStack.size()>0){
            for(String s: tableStack){
                if(s.indexOf(SOURCE)>=0)
                    sourceExist=true;
                if(s.indexOf(DESTINATION)>=0)
                    destinationExist=true;
            }
            if(sourceExist && destinationExist){
                
                System.out.println("------------------- "+sqlType+ " --------------------------");
                // print the part in SQL
                while(tableStack.size()>0){
                    tmpStr=tableStack.pop();
                   
                    System.out.println(tmpStr);
//                    try{
//                        this.bfw.write(tmpStr+"\n");
//                    }catch(IOException e){
//                        System.err.println("Fail to write the output file");
//                    }
                    if(tmpStr.startsWith(SOURCE))
                        upperStreamTableName.add(tmpStr.replace(SOURCE+":", ""));
                    else
                        downStreamTableName=tmpStr.replace(DESTINATION+":", "");
                }
                
                
                // print the part in cursor
                for(String s: processingCursorNames){
                    tmpList=cursorQueryTable.get(s);
                    if(tmpList!=null && tmpList.size()>0){
                        for(String t: tmpList){
                            
                            System.out.println(SOURCE+"[CURSOR]:"+t);
                            upperStreamTableName.add(t);
                        }
                    }
                }                
                //System.out.println("-------------------------------------------");
                if(downStreamTableName!=null){
                   
                    for(String s: upperStreamTableName){
//                        System.out.println("merge (t:Table {Name:\""+s+"\"}) return t;");
//                        System.out.println("MATCH (t1:Table { Name: \""+s+"\" }),(t2:Table {Name: \""+downStreamTableName+"\" }) MERGE (t1)-[r:DOWNSTREAM]->(t2);");
                        System.out.println("source table:"+s+"/destination table:"+downStreamTableName);
                        try{
                            this.bfw.write(this.sqlFileName+","+s+","+downStreamTableName+"\n"); // csv format
                            
                        }catch(IOException e){
                            System.err.println("Fail to write the output file");
                        }
                     
                    }
                 
                }
               
                
            }else
                tableStack.clear();
        }
        
        if(tmpTableStack!=null && tmpTableStack.size()>0){
            for(String s: tmpTableStack){
                System.out.println("Temp table:\""+s+"\"");
//                try{
//                    this.bfw.write(s+"\n");
//                }catch(IOException e){
//                    System.err.println("Fail to write the output file");
//                }
               
            }
            tmpTableStack.clear();
        }
//        else{
//            //System.out.println("No temp table");
//            try{
//                this.bfw.write("No temp file\n");
//            }catch(IOException e){
//                System.err.println("Fail to write the output file");
//            }
//        }
        tmpTableStack.clear();
        try{
            this.bfw.flush();
        }catch(IOException e){
            System.err.println("Fail to write the output file");
        }
    }
    
//    private void ingestDataIntoNeo4j(final String data){
//        Driver driver = GraphDatabase.driver( this.neo4jHost, AuthTokens.basic( this.neo4jUsername, this.neo4jPassword ) );
//        try ( Session session = driver.session() )
//        {
//            String greeting = session.writeTransaction( new TransactionWork<String>()
//            {
//                @Override
//                public String execute( Transaction tx )
//                {
//                    StatementResult result = tx.run(data );
//                    return "";//result.single().get( 0 ).asString();
//                }
//            } );
//            
//        }
//        driver.close();
//    }
//    
    @Override public void enterCursor_declaration(@NotNull PlSqlParser.Cursor_declarationContext ctx) { 
        int size=ctx.getChildCount();
        for(int i=0; i<size; i++){
            if(ctx.getChild(i).getClass().getName().equalsIgnoreCase("PlSqlParser$IdentifierContext"))
                tempCursorName=ctx.getChild(i).getText();
        }
      
        isInCursorDeclaration=true;
    }
    @Override public void exitCursor_declaration(@NotNull PlSqlParser.Cursor_declarationContext ctx) { 
        tempCursorName=null;
        isInCursorDeclaration=false;
    }
    @Override public void exitInsert_statement(@NotNull PlSqlParser.Insert_statementContext ctx) { 
        this.printStackInfo("Insert");
    }
    @Override public void exitDelete_statement(@NotNull PlSqlParser.Delete_statementContext ctx) { 
        this.printStackInfo("Delete");
    }
    
    @Override public void exitUpdate_statement(@NotNull PlSqlParser.Update_statementContext ctx) { 
        this.printStackInfo("Update");
    }
    
    @Override public void enterStatement(@NotNull PlSqlParser.StatementContext ctx) { 
        if(!inLoop){
            tableStack.clear();
            statusStack.clear();     
            processingCursorNames.clear();
        }
    }
    
    
 
    @Override public void enterInsert_into_clause(@NotNull PlSqlParser.Insert_into_clauseContext ctx) { 
        statusStack.push(DESTINATION);
    }
    
    /**
     * {@inheritDoc}
     *
     * <p>The default implementation does nothing.</p>
     */
    @Override public void exitInsert_into_clause(@NotNull PlSqlParser.Insert_into_clauseContext ctx) {
       // intoDestination=false;
        if(statusStack.size()>0)
            statusStack.pop();
    }
    
    
    @Override public void enterFrom_clause(@NotNull PlSqlParser.From_clauseContext ctx) { 
        statusStack.push(SOURCE);
        
    }
    
    @Override public void enterDelete_statement(@NotNull PlSqlParser.Delete_statementContext ctx) { 
        int length=ctx.getChildCount();
        for(int i=0; i<length; i++){
            if(ctx.getChild(i).getClass().getName().equalsIgnoreCase("PlSqlParser$General_table_refContext")){
                
                for(int j=0; j< ctx.getChild(i).getChildCount(); j++){
                    if(ctx.getChild(i).getChild(j).getClass().getName().equalsIgnoreCase("PlSqlParser$Dml_table_expression_clauseContext")){
                        statusStack.push(DESTINATION);
                    }
                }
            }              
        }
    }
    
    @Override public void enterUpdate_statement(@NotNull PlSqlParser.Update_statementContext ctx) { 
        int length=ctx.getChildCount();
        for(int i=0; i<length; i++){
            if(ctx.getChild(i).getClass().getName().equalsIgnoreCase("PlSqlParser$General_table_refContext")){
                
                for(int j=0; j< ctx.getChild(i).getChildCount(); j++){
                    if(ctx.getChild(i).getChild(j).getClass().getName().equalsIgnoreCase("PlSqlParser$Dml_table_expression_clauseContext")){
                        statusStack.push(DESTINATION);
                    }
                }
            }              
        }
    }
    
    /**
     * {@inheritDoc}
     *
     * <p>The default implementation does nothing.</p>
     */
    @Override public void enterCursor_name(@NotNull PlSqlParser.Cursor_nameContext ctx) {
        processingCursorNames.add(ctx.getText());
    }
    @Override public void enterCursor_loop_param(@NotNull PlSqlParser.Cursor_loop_paramContext ctx) {
       
    }
    /**
     * {@inheritDoc}
     *
     * <p>The default implementation does nothing.</p>
     */
    @Override public void exitCursor_name(@NotNull PlSqlParser.Cursor_nameContext ctx) { }
    
    /**
     * {@inheritDoc}
     *
     * <p>The default implementation does nothing.</p>
     */
    @Override public void exitFrom_clause(@NotNull PlSqlParser.From_clauseContext ctx) { 
        if(statusStack.size()>0)
            statusStack.pop();
    }
    
    @Override public void enterTableview_name(@NotNull PlSqlParser.Tableview_nameContext ctx) { 
        String tableName;
        boolean inSourceTable=false;
        //System.out.println("Enter: "+ctx.getText());
        if(statusStack.size()>0 && ctx.getText().length()>3){
            if(statusStack.get((statusStack.size()-1)).indexOf(DESTINATION)>=0 ){                            
                tableName=ctx.getText();
                if(tableList.containsKey(tableName.toUpperCase()) || tableList2.contains(tableName.toUpperCase())){
                    tableStack.push(DESTINATION+":"+ctx.getText());
                }else{
                    if(ctx.getText().indexOf("ods_system")<0 && ctx.getText().indexOf("ODS_SYSTEM")<0)
                        tmpTableStack.push("[TEMP_TABLE(DESTINATION)]:"+ctx.getText());// record temp table
                }
            }else {
                tableName=ctx.getText();
                if(tableList.containsKey(tableName.toUpperCase())  || tableList2.contains(tableName.toUpperCase())){
                    tableStack.push(SOURCE+":"+tableName);
                    inSourceTable=true;
                }
                if(isInCursorDeclaration){
                    List<String> tmpList=cursorQueryTable.get(this.tempCursorName);
                    if(tmpList==null || tmpList.isEmpty())
                        tmpList=new ArrayList<String>();
                     
                         
                    tmpList.add(ctx.getText());
                     
                   // System.out.println("Source Table:" + ctx.getText());
                    cursorQueryTable.put(this.tempCursorName, tmpList);
                    
                    inSourceTable=true;
                }
                if(!inSourceTable){
                    if(ctx.getText().indexOf("ods_system")<0 && ctx.getText().indexOf("ODS_SYSTEM")<0)
                        tmpTableStack.push("[TEMP_TABLE(SOURCE)]:"+ctx.getText());
                }
            }
        }

    }
    @Override public void enterSeq_of_statements(@NotNull PlSqlParser.Seq_of_statementsContext ctx) { 
        
       
    }
    
    @Override public void enterLoop_statement(@NotNull PlSqlParser.Loop_statementContext ctx) { 
        tableStack.clear();
        statusStack.clear();     
        processingCursorNames.clear();
        inLoop=true;
    }
    @Override public void exitLoop_statement(@NotNull PlSqlParser.Loop_statementContext ctx) { 
        tableStack.clear();
        statusStack.clear();     
        processingCursorNames.clear();
        inLoop=false;
    }
    
    @Override public void enterMerge_statement(@NotNull PlSqlParser.Merge_statementContext ctx) {    
        tableStack.clear();
        statusStack.clear();     
               
       // ctx.getChild(i)
       
        statusStack.push(DESTINATION);
        
    }
    
    @Override public void exitMerge_statement(@NotNull PlSqlParser.Merge_statementContext ctx) {
        this.printStackInfo("Merge");    
    }
    
   
    public static String getFileListName(String path){      
        File f=new File(path);
        if(f.isFile()){
            if(f.getAbsolutePath().endsWith(".sql") || f.getAbsolutePath().endsWith(".SQL"))
                return f.getAbsolutePath();
            else
                return null;
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
    
    //get a writer
    public static BufferedWriter getWriter(String path) throws IOException{
        Path p= FileSystems.getDefault().getPath(path);
        Charset charset = Charset.forName(UTF_8);
        BufferedWriter writer=null;
        try  {
            writer = Files.newBufferedWriter(p, charset);
        } catch (IOException x) {
            System.err.format("IOException: %s%n", x);
            throw x;
        }
        return writer;
    }
    
	/**
	 * @param args
	 */
	@SuppressWarnings("deprecation")
	public static void main(String[] args) throws Exception{

	    if(args.length<5){
	        System.err.println("Missing necessary arguments \n");
	        System.out.println("Parameters:java PlsqlTableScanner SQL_FILE RESULT_CSV_FILE_PATH LOG_FILE_PATH TABLE_LIST_FILE1 TABLE_LIST_FILE2 ");
	        System.out.println("The format of TABLE_LIST_FILEx: OWNER_NAME,TABLE_NAME|VIEW_NAME,COLUMN_NAME ");
	        System.out.println("                            eg: ABC_REPL,CARDTYPE,YYYYMM");
	        System.exit(1);;
	    }
	        
		String inputFile=args[0];//"D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/c1.sql";
		String reportFile=args[1]; // write csv in reportFile
	    PrintStream console=System.out; // console output
	    File logFile=new File(args[2]);
	    FileOutputStream logFileOutputStream=new FileOutputStream(logFile);
		String [] tableList=new String[args.length-3];
		
		// set up table list
		for(int i=3; i<args.length; i++)
		    if(args[i]!=null)
		        tableList[i-3]=args[i];
		System.out.println("------------------- START ----------------------");
		System.out.println("Input SQL file: " + inputFile);
		System.out.println("CSV file: "+ reportFile);
		System.out.println("Log file: "+args[2]);
		System.out.println("Table defintion list: ");
		for(String s: tableList){
		    System.out.println("\t"+s);
		}
		System.out.println();

		Charset cs=StandardCharsets.UTF_8;
		//Scanner scanner;
		File f=new File(inputFile);
		BufferedWriter writer=PlsqlTableScanner.getWriter(reportFile);
		
		// use file as standard output and standard error output
		PrintStream filePrintStream=new PrintStream(logFileOutputStream);
		System.setErr(filePrintStream);
		System.setOut(filePrintStream);
        if(f.isFile()){
            System.out.println("File path: " + inputFile);
            writer.write(CSV_FILE_FIELDS+"\n");  
            CharStream csm=CharStreams.fromFileName(inputFile, cs);
           // CharStream csm=CharStreams.fromFileName(inputFile);
            PlSqlLexer lexer=new PlSqlLexer(csm);
            CommonTokenStream tokens=new CommonTokenStream(lexer);
            PlSqlParser parser=new PlSqlParser(tokens);
            ParseTree tree=parser.compilation_unit();       
            ParseTreeWalker walker=new ParseTreeWalker();
            PlsqlTableScanner extracter=null;
            extracter=new PlsqlTableScanner(parser, writer,inputFile, tableList);          
            System.out.println();
            //writer.write("\n");
            walker.walk(extracter, tree);
            writer.flush();
            writer.close();
            
        }
        
        // a directory
        if(f.isDirectory()){
            String result=PlsqlTableScanner.getFileListName(inputFile);
            String[] inputArr=result.split("\n");
            int index=0;
            writer.write(CSV_FILE_FIELDS+"\n");  
            for(String s: inputArr){
                if(s.length()>1){
                    index+=1;
                    System.out.println(index+":"+s);
                   // writer.write("("+(index+1)+".) " +"File path: "+ s); 
                    //InputStream is = new FileInputStream(s);
                    //Reader r=new InputStreamReader(is, "utf-8"); 
                    CharStream csm=CharStreams.fromFileName(s, cs);
                   // CharStream csm=CharStreams.fromFileName(s);
                    //ANTLRInputStream input = new ANTLRInputStream(r);
                    PlSqlLexer lexer=new PlSqlLexer(csm);
                    //PlSqlLexer lexer=new PlSqlLexer(input);
                    CommonTokenStream tokens=new CommonTokenStream(lexer);
                    PlSqlParser parser=new PlSqlParser(tokens);
                    ParseTree tree=parser.compilation_unit();       
                    ParseTreeWalker walker=new ParseTreeWalker();
                    PlsqlTableScanner extracter=null;
                    extracter=new PlsqlTableScanner(parser, writer,s, tableList);        
                    System.out.println();
                   // writer.write("\n");
                    walker.walk(extracter, tree);
                    
                    
                }
            }
            writer.flush();
            writer.close();;
            System.out.println("Total number of processed files: "+index);
            
        }
        
        // use console as standard output and standard error output
        System.setErr(console);
        System.setOut(console);
        System.out.println("------------------- DONE -----------------------");
	}

}
