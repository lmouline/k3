/*
* generated by Xtext
*/
package insa.parser.antlr;

import com.google.inject.Inject;

import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import insa.services.LegoGrammarAccess;

public class LegoParser extends org.eclipse.xtext.parser.antlr.AbstractAntlrParser {
	
	@Inject
	private LegoGrammarAccess grammarAccess;
	
	@Override
	protected void setInitialHiddenTokens(XtextTokenStream tokenStream) {
		tokenStream.setInitialHiddenTokens("RULE_SL_COMMENT", "RULE_ML_COMMENT", "RULE_WS");
	}
	
	@Override
	protected insa.parser.antlr.internal.InternalLegoParser createParser(XtextTokenStream stream) {
		return new insa.parser.antlr.internal.InternalLegoParser(stream, getGrammarAccess());
	}
	
	@Override 
	protected String getDefaultRuleName() {
		return "ProgramUnit";
	}
	
	public LegoGrammarAccess getGrammarAccess() {
		return this.grammarAccess;
	}
	
	public void setGrammarAccess(LegoGrammarAccess grammarAccess) {
		this.grammarAccess = grammarAccess;
	}
	
}
