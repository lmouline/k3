/*
* generated by Xtext
*/
package org.kermeta.language.sample.cellularautomata.rules.parser.antlr;

import java.io.InputStream;
import org.eclipse.xtext.parser.antlr.IAntlrTokenFileProvider;

public class CoreAntlrTokenFileProvider implements IAntlrTokenFileProvider {
	
	public InputStream getAntlrTokenFile() {
		ClassLoader classLoader = getClass().getClassLoader();
    	return classLoader.getResourceAsStream("org/kermeta/language/sample/cellularautomata/rules/parser/antlr/internal/InternalCore.tokens");
	}
}