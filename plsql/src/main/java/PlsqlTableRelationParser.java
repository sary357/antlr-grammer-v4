/**
 * 
 */

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.tree.*;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Stack;
/**
 *
 */
public class PlsqlTableRelationParser extends PlSqlParserBaseListener{
    private PlSqlParser parser;
  
    public static final String DESTINATION="[destination:insert][delete target:delete][update target table:update]"; // destination
    public static final String SOURCE="[source:insert][delete source table:delete][update source table: update]"; // source
    private Stack<String> tableStack=new Stack<String>();
    private Stack<String> statusStack=new Stack<String>();
    private boolean isInCursorDeclaration=false;
    private boolean inLoop=false;
    
    private Map<String,List<String>> cursorQueryTable=new HashMap<String, List<String>>(); // key=cursor_name, value=table1,table2,...,etc
    private String tempCursorName=null;
    private Set<String> processingCursorNames=new HashSet<String>();
    public PlsqlTableRelationParser(PlSqlParser parser){
        this.parser=parser;
    }   
    
    private void printStackInfo(String sqlType){
        boolean sourceExist=false;
        boolean destinationExist=false;
        List<String> tmpList;
       
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
                while(tableStack.size()>0)
                    System.out.println(tableStack.pop());
                
                // print the part in cursor
                for(String s: processingCursorNames){
                    tmpList=cursorQueryTable.get(s);
                    for(String t: tmpList)
                        System.out.println(SOURCE+"[CURSOR]:"+t);
                }
                   // System.out.println(SOURCE+":"+cursorQueryTable.get(s));
                System.out.println("-----------------------------------------------------");
            }else
                tableStack.clear();
        }
        
       
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
        //System.out.println("GGGGGGGGGG121212GGGGGGGGGGG");
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
        
        if(statusStack.size()>0 && ctx.getText().length()>3){
            if(statusStack.get((statusStack.size()-1)).indexOf(DESTINATION)>=0 ){
                tableStack.push(DESTINATION+":"+ctx.getText());
                //System.out.println("Destination Table:" + ctx.getText());
            }else {
               
                tableStack.push(SOURCE+":"+ctx.getText());
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
	/**
	 * @param args
	 */
	@SuppressWarnings("deprecation")
	public static void main(String[] args) throws Exception{
		// TODO Auto-generated method stub
		String inputFile=args[0];//"D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/c1.sql";
		InputStream is = new FileInputStream(inputFile);
		ANTLRInputStream input = new ANTLRInputStream(is);
		PlSqlLexer lexer=new PlSqlLexer(input);
		CommonTokenStream tokens=new CommonTokenStream(lexer);
		PlSqlParser parser=new PlSqlParser(tokens);
		ParseTree tree=parser.compilation_unit();
		
		ParseTreeWalker walker=new ParseTreeWalker();
		PlsqlTableRelationParser extracter=new PlsqlTableRelationParser(parser);
		System.out.println();
		walker.walk(extracter, tree);
		//System.out.println("-----------------------------");
		//System.out.println(tree.toStringTree(parser));
	}

}
