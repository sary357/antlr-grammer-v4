/**
 * 
 */

import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;
import java.io.FileInputStream;
import java.io.InputStream;
/**
 * @author sary357
 *
 */
public class PlsqlTableRelationParser extends PlSqlParserBaseListener{

	/**
	 * @param args
	 */
	@SuppressWarnings("deprecation")
	public static void main(String[] args) throws Exception{
		// TODO Auto-generated method stub
		String inputFile="D:/fuming.Tsai/Documents/Tools/PortableGit/projects/grammars-v4/plsql/fubon/c1.sql";
		InputStream is = new FileInputStream(inputFile);
		ANTLRInputStream input = new ANTLRInputStream(is);
		PlSqlLexer lexer=new PlSqlLexer(input);
		CommonTokenStream tokens=new CommonTokenStream(lexer);
		PlSqlParser parser=new PlSqlParser(tokens);
		ParseTree tree=parser.compilation_unit();
		System.out.println(tree.toStringTree(parser));
	}

}
