/**
 * 
 */

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.tree.*;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashSet;
import java.util.Set;
import java.util.Stack;
/**
 *
 */
public class PlsqlTableRelationParser extends PlSqlParserBaseListener{
    private Set<String> ownerSet=new HashSet();
    private PlSqlParser parser;
  
  //  private boolean tableScope;
   // private boolean noNeedToDecideAlias;
   // private String tableName;
    public static final String DESTINATION="destination"; // destination
    public static final String SOURCE="source"; // source
    private Stack<String> tableStack=new Stack<String>();
    private Stack<String> statusStack=new Stack<String>();
    
    //private boolean isDelete=false;
    public PlsqlTableRelationParser(PlSqlParser parser){
        this.parser=parser;
       // useful=false;
  //      tableScope=false;
    }

    private void init(){
       
       
    }

    @Override public void exitInsert_statement(@NotNull PlSqlParser.Insert_statementContext ctx) { 
        boolean sourceExist=false;
        boolean destinationExist=false;
        
        if(tableStack.size()>0){
            for(String s: tableStack){
                if(s.indexOf(SOURCE)>=0)
                    sourceExist=true;
                if(s.indexOf(DESTINATION)>=0)
                    destinationExist=true;
            }
            if(sourceExist && destinationExist){
                System.out.println("------------------- Insert --------------------------");
                while(tableStack.size()>0)
                    System.out.println(tableStack.pop());
                System.out.println("-----------------------------------------------------");
            }else
                while(tableStack.size()>0)
                    tableStack.pop();
        }
    }
    
    @Override public void exitDelete_statement(@NotNull PlSqlParser.Delete_statementContext ctx) { 
        boolean sourceExist=false;
        boolean destinationExist=false;
       // isDelete=false;
        if(tableStack.size()>0){
            for(String s: tableStack){
                if(s.indexOf(SOURCE)>=0)
                    sourceExist=true;
                if(s.indexOf(DESTINATION)>=0)
                    destinationExist=true;
            }
            if(sourceExist && destinationExist){
                System.out.println("------------------- Delete --------------------------");
                while(tableStack.size()>0)
                    System.out.println(tableStack.pop());
                System.out.println("-----------------------------------------------------");
            }else
                while(tableStack.size()>0)
                    tableStack.pop();
        }
    }
    
    
    @Override public void enterInsert_into_clause(@NotNull PlSqlParser.Insert_into_clauseContext ctx) { 
       // intoDestination=true;
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
               //     System.out.println(ctx.getChild(i).getChild(j).getClass().getName());
               //     System.out.println(ctx.getChild(i).getChild(j).getText());
                    if(ctx.getChild(i).getChild(j).getClass().getName().equalsIgnoreCase("PlSqlParser$Dml_table_expression_clauseContext")){
                       // tableStack.push(DESTINATION+":"+ctx.getChild(i).getChild(j).getText());
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
                //System.out.println("Source Table:" + ctx.getText());
            }
        }

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
