/**
 * 
 */

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.tree.*;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Stack;
import org.neo4j.driver.v1.*;
import static org.neo4j.driver.v1.Values.parameters;
/**
 * after executing this class, you will get the relationship between tables in Neo4j. However, the relationship between column and tables will not exist in this class.
 * 
 */
public class PlsqlColumnTableRelationParser extends PlSqlParserBaseListener{
    private PlSqlParser parser;
  
    public static final String DESTINATION="[destination:insert][delete target:delete][update target table:update][merge into destination table: merge]"; // destination
    public static final String SOURCE="[source:insert][delete source table:delete][update source table: update][merge source table: merge]"; // source
    private Stack<String> tableStack=new Stack<String>();
    private Stack<String> statusStack=new Stack<String>();
    private boolean isInCursorDeclaration=false;
    private boolean inLoop=false;
    
    private Map<String,List<String>> cursorQueryTable=new HashMap<String, List<String>>(); // key=cursor_name, value=table1,table2,...,etc
    private String tempCursorName=null;
    private Set<String> processingCursorNames=new HashSet<String>();
    private Map<String, Set<String>> tableList=null; // key: owner.table  value(a set): column
    private Set<String> tableList2=new HashSet<String>(); // table name only
    private boolean initialized=false;
    
    private String neo4jHost;
    private String neo4jUsername;
    private String neo4jPassword;
    
    private Map<String, Set<String>> tableAlias=new HashMap<String,Set<String>>(); // key: alias, value: table name
//    public PlsqlTableRelationParser(PlSqlParser parser){
//        this.parser=parser;
//    }   
    
    public PlsqlColumnTableRelationParser(PlSqlParser parser, String host, String username, String password, String[] fileName){
        this.parser=parser;
        this.neo4jUsername=username;
        this.neo4jHost=host;
        this.neo4jPassword=password;
        this.ingestTableList(fileName);
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
                System.out.println("Read content from file: "+f);
                
                in = new BufferedReader(new FileReader(f));
                while((line=in.readLine()) != null)
                {
                      // System.out.println(line);
                       String[] tmpStrArr=line.split(",");
                       if(tmpStrArr.length==3){
                           tableName=tmpStrArr[0].trim().toUpperCase()+"."+tmpStrArr[1].trim().toUpperCase();
                           columnName=tmpStrArr[2];
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
                    if(tmpStr.startsWith(SOURCE))
                        upperStreamTableName.add(tmpStr.replace(SOURCE+":", ""));
                    else
                        downStreamTableName=tmpStr.replace(DESTINATION+":", "");
                }
                
                
                // print the part in cursor
                for(String s: processingCursorNames){
                    tmpList=cursorQueryTable.get(s);
                    for(String t: tmpList){
                        
                        System.out.println(SOURCE+"[CURSOR]:"+t);
                        upperStreamTableName.add(t);
                    }
                }
                   // System.out.println(SOURCE+":"+cursorQueryTable.get(s));
                
                //System.out.println("-------------------------------------------");
                
                if(downStreamTableName!=null){
                    Set<String> dColumnSet=this.tableList.get(downStreamTableName);
                    if(!isTableExists(downStreamTableName)){// create destination table in neo4j
                        System.out.println("------------------ Creating destination table:"+downStreamTableName+" in neo4j -------------------------");
                        this.ingestDataIntoNeo4j("create (t:Table {Name:\""+downStreamTableName+"\"});"); // print downstream table and columns                       
                       
                        for(String columns: dColumnSet){
                            //System.out.println(columns);
                            this.ingestDataIntoNeo4j("create (c:Column {Name:\""+columns+"\",SearchName:\""+downStreamTableName+"."+columns+"\"}) ;");
                            this.ingestDataIntoNeo4j("MATCH (t:Table { Name:\""+downStreamTableName+"\" }),(c:Column {SearchName:\""+downStreamTableName+"."+columns+"\" }) create unique (t)-[:HAVE]->(c);");
                        }
                    }else{
                        System.out.println("------------------ Destination table:"+downStreamTableName+" exists in neo4j -------------------------");
                    }
                    
                    
                   // source table
                    //this.ingestDataIntoNeo4j("merge (t:Table {Name:\""+downStreamTableName+"\"})");
                    for(String s: upperStreamTableName){
                        if(!isTableExists(s)){
                            System.out.println("------------------ Creating source table:"+s+" in neo4j -------------------------");
                            this.ingestDataIntoNeo4j("create (t:Table {Name:\""+s+"\"});");
                            Set<String> sColumnSet=this.tableList.get(s);
                            for(String column: sColumnSet){
                                
                                this.ingestDataIntoNeo4j("CREATE (c:Column {Name:\""+column+"\",SearchName:\""+s+"."+column+"\"}) ;");
                                this.ingestDataIntoNeo4j("MATCH (t:Table { Name:\""+s+"\" }),(c:Column {SearchName:\""+s+"."+column+"\" }) create unique (t)-[:HAVE]->(c);");                                
                            }                          
                        }else{
                            System.out.println("------------------ Source table:"+s+" exists in neo4j -------------------------");
                        }
                    }
                   
                  
                    
                    System.out.println("------- Trying to match column by column name -----");
                    for(String s: upperStreamTableName){
                        Set<String> sColumnSet=this.tableList.get(s);
                        for(String column: sColumnSet){
                            if(dColumnSet.contains(column)){
                                //System.out.println("match column name");
                                this.ingestDataIntoNeo4j("MATCH (c1:Column { SearchName:\""+downStreamTableName+"."+column+"\" }),(c2:Column {SearchName:\""+s+"."+column+"\" }) create unique (c1)<-[:DOWNSTREAM]-(c2);");
                            }
                        }
                        
                        for(String column: dColumnSet){
                            if(sColumnSet.contains(column)){
                              //  System.out.println("match column name");
                                this.ingestDataIntoNeo4j("MATCH (c1:Column { SearchName:\""+s+"."+column+"\" }),(c2:Column {SearchName:\""+downStreamTableName+"."+column+"\" }) create unique (c1)-[:DOWNSTREAM]->(c2);");
                            }
                        }
                    }
                    System.out.println("match (t:Table)-[r:HAVE]-(c:Column) return t,r,c;");
                }
                System.out.println("----------------- Data have been ingested by neo4j ---------------------------");
                
            }else
                tableStack.clear();
        }
    }
    
    private boolean isTableExists(String tableName){
        Driver driver = GraphDatabase.driver( this.neo4jHost, AuthTokens.basic( this.neo4jUsername, this.neo4jPassword ) );
        boolean result=false;
        Session session=driver.session();
        StatementResult stmtResult = session.run("MATCH (t:Table) WHERE t.Name = {name} " +
                "RETURN t.Name",parameters( "name", tableName ));
        if(stmtResult.hasNext())
            result=true;
        session.close();
        driver.close();
        return result;
    }
    
    private void ingestDataIntoNeo4j(final String data){
        Driver driver = GraphDatabase.driver( this.neo4jHost, AuthTokens.basic( this.neo4jUsername, this.neo4jPassword ) );
        //System.out.println(data);
        try ( Session session = driver.session() )
        {
            String greeting = session.writeTransaction( new TransactionWork<String>()
            {
                @Override
                public String execute( Transaction tx )
                {
                    StatementResult result = tx.run(data );
                    return "";//result.single().get( 0 ).asString();
                }
            } );
            
        }
        driver.close();
    }
    
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
        statusStack.pop();
    }
    
    @Override public void enterTableview_name(@NotNull PlSqlParser.Tableview_nameContext ctx) { 
        String tableName;
        
        if(statusStack.size()>0 && ctx.getText().length()>3){
            if(statusStack.get((statusStack.size()-1)).indexOf(DESTINATION)>=0 ){                            
                tableName=ctx.getText();
                if(tableList.containsKey(tableName.toUpperCase()) || tableList2.contains(tableName.toUpperCase())){
                    tableStack.push(DESTINATION+":"+ctx.getText());
                    //System.out.println("Destination Table:" + ctx.getText());
                }
            }else {
                tableName=ctx.getText();
                if(tableList.containsKey(tableName.toUpperCase())  || tableList2.contains(tableName.toUpperCase())){
                    tableStack.push(SOURCE+":"+tableName);
                }
                if(isInCursorDeclaration){
                    List<String> tmpList=cursorQueryTable.get(this.tempCursorName);
                    if(tmpList==null || tmpList.isEmpty())
                        tmpList=new ArrayList<String>();
                     
                         
                    tmpList.add(ctx.getText());
                     
                   // System.out.println("Source Table:" + ctx.getText());
                    cursorQueryTable.put(this.tempCursorName, tmpList);
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
    
   
    
	/**
	 * @param args
	 */
	@SuppressWarnings("deprecation")
	public static void main(String[] args) throws Exception{
	    if(args.length<5){
	        System.err.println("Missing necessary arguments \n");
	        System.out.println("Parameters:java PlsqlColumnTableRelationParser  NEO4J_HOST NEO4J_USERNAME NEO4J_PASSWORD SQL_FILE TABLE_LIST_FILE1 TABLE_LIST_FILE2 ");
	        System.out.println("The format of TABLE_LIST_FILEx: OWNER_NAME,TABLE_NAME|VIEW_NAME,COLUMN_NAME ");
	        System.out.println("                            eg: ABC_REPL,CARDTYPE,YYYYMM");
	        System.exit(1);;
	    }
	        
		String inputFile=args[3];//"D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/c1.sql";
		String [] tableList=new String[args.length-4];
		for(int i=4; i<args.length; i++)
		    if(args[i]!=null)
		        tableList[i-4]=args[i];
		InputStream is = new FileInputStream(inputFile);
		ANTLRInputStream input = new ANTLRInputStream(is);
		PlSqlLexer lexer=new PlSqlLexer(input);
		CommonTokenStream tokens=new CommonTokenStream(lexer);
		PlSqlParser parser=new PlSqlParser(tokens);
		ParseTree tree=parser.compilation_unit();
		
		ParseTreeWalker walker=new ParseTreeWalker();
		PlsqlColumnTableRelationParser extracter=new PlsqlColumnTableRelationParser(parser,args[0], args[1], args[2], tableList);
		System.out.println();
		
		walker.walk(extracter, tree);
		
		//System.out.println("-----------------------------");
		//System.out.println(tree.toStringTree(parser));
	}

}
