/*
* generated by Xtext
*/
package org.kermeta.language.sample.cellularautomata.rules.ui.contentassist.antlr;

import java.util.Collection;
import java.util.Map;
import java.util.HashMap;

import org.antlr.runtime.RecognitionException;
import org.eclipse.xtext.AbstractElement;
import org.eclipse.xtext.ui.editor.contentassist.antlr.AbstractContentAssistParser;
import org.eclipse.xtext.ui.editor.contentassist.antlr.FollowElement;
import org.eclipse.xtext.ui.editor.contentassist.antlr.internal.AbstractInternalContentAssistParser;

import com.google.inject.Inject;

import org.kermeta.language.sample.cellularautomata.rules.services.InitGrammarAccess;

public class InitParser extends AbstractContentAssistParser {
	
	@Inject
	private InitGrammarAccess grammarAccess;
	
	private Map<AbstractElement, String> nameMappings;
	
	@Override
	protected org.kermeta.language.sample.cellularautomata.rules.ui.contentassist.antlr.internal.InternalInitParser createParser() {
		org.kermeta.language.sample.cellularautomata.rules.ui.contentassist.antlr.internal.InternalInitParser result = new org.kermeta.language.sample.cellularautomata.rules.ui.contentassist.antlr.internal.InternalInitParser(null);
		result.setGrammarAccess(grammarAccess);
		return result;
	}
	
	@Override
	protected String getRuleName(AbstractElement element) {
		if (nameMappings == null) {
			nameMappings = new HashMap<AbstractElement, String>() {
				private static final long serialVersionUID = 1L;
				{
					put(grammarAccess.getLiteralsExpressionAccess().getAlternatives(), "rule__LiteralsExpression__Alternatives");
					put(grammarAccess.getDimensionAccess().getAlternatives(), "rule__Dimension__Alternatives");
					put(grammarAccess.getConditionalAccess().getAlternatives(), "rule__Conditional__Alternatives");
					put(grammarAccess.getComparisonExpressionAccess().getAlternatives_1_0(), "rule__ComparisonExpression__Alternatives_1_0");
					put(grammarAccess.getAddExpressionAccess().getAlternatives_1_0(), "rule__AddExpression__Alternatives_1_0");
					put(grammarAccess.getMultExpressionAccess().getAlternatives_1_0(), "rule__MultExpression__Alternatives_1_0");
					put(grammarAccess.getUnaryExpressionAccess().getAlternatives(), "rule__UnaryExpression__Alternatives");
					put(grammarAccess.getCellularAutomataInitializationAccess().getGroup(), "rule__CellularAutomataInitialization__Group__0");
					put(grammarAccess.getRuleAccess().getGroup(), "rule__Rule__Group__0");
					put(grammarAccess.getGlobalPositionAccess().getGroup(), "rule__GlobalPosition__Group__0");
					put(grammarAccess.getGlobalPositionAccess().getGroup_3(), "rule__GlobalPosition__Group_3__0");
					put(grammarAccess.getCoordinateRangeAccess().getGroup(), "rule__CoordinateRange__Group__0");
					put(grammarAccess.getLiteralsExpressionAccess().getGroup_0(), "rule__LiteralsExpression__Group_0__0");
					put(grammarAccess.getPositionLiteralAccess().getGroup(), "rule__PositionLiteral__Group__0");
					put(grammarAccess.getRegularGeometryAccess().getGroup(), "rule__RegularGeometry__Group__0");
					put(grammarAccess.getRegularGeometryAccess().getGroup_5(), "rule__RegularGeometry__Group_5__0");
					put(grammarAccess.getDimensionAccess().getGroup_0(), "rule__Dimension__Group_0__0");
					put(grammarAccess.getDimensionAccess().getGroup_1(), "rule__Dimension__Group_1__0");
					put(grammarAccess.getConditionalAccess().getGroup_1(), "rule__Conditional__Group_1__0");
					put(grammarAccess.getOrExpressionAccess().getGroup(), "rule__OrExpression__Group__0");
					put(grammarAccess.getOrExpressionAccess().getGroup_1(), "rule__OrExpression__Group_1__0");
					put(grammarAccess.getAndExpressionAccess().getGroup(), "rule__AndExpression__Group__0");
					put(grammarAccess.getAndExpressionAccess().getGroup_1(), "rule__AndExpression__Group_1__0");
					put(grammarAccess.getEqualExpressionAccess().getGroup(), "rule__EqualExpression__Group__0");
					put(grammarAccess.getEqualExpressionAccess().getGroup_1(), "rule__EqualExpression__Group_1__0");
					put(grammarAccess.getComparisonExpressionAccess().getGroup(), "rule__ComparisonExpression__Group__0");
					put(grammarAccess.getComparisonExpressionAccess().getGroup_1(), "rule__ComparisonExpression__Group_1__0");
					put(grammarAccess.getComparisonExpressionAccess().getGroup_1_0_0(), "rule__ComparisonExpression__Group_1_0_0__0");
					put(grammarAccess.getComparisonExpressionAccess().getGroup_1_0_1(), "rule__ComparisonExpression__Group_1_0_1__0");
					put(grammarAccess.getAddExpressionAccess().getGroup(), "rule__AddExpression__Group__0");
					put(grammarAccess.getAddExpressionAccess().getGroup_1(), "rule__AddExpression__Group_1__0");
					put(grammarAccess.getAddExpressionAccess().getGroup_1_0_0(), "rule__AddExpression__Group_1_0_0__0");
					put(grammarAccess.getAddExpressionAccess().getGroup_1_0_1(), "rule__AddExpression__Group_1_0_1__0");
					put(grammarAccess.getMultExpressionAccess().getGroup(), "rule__MultExpression__Group__0");
					put(grammarAccess.getMultExpressionAccess().getGroup_1(), "rule__MultExpression__Group_1__0");
					put(grammarAccess.getMultExpressionAccess().getGroup_1_0_0(), "rule__MultExpression__Group_1_0_0__0");
					put(grammarAccess.getMultExpressionAccess().getGroup_1_0_1(), "rule__MultExpression__Group_1_0_1__0");
					put(grammarAccess.getMultExpressionAccess().getGroup_1_0_2(), "rule__MultExpression__Group_1_0_2__0");
					put(grammarAccess.getUnaryExpressionAccess().getGroup_1(), "rule__UnaryExpression__Group_1__0");
					put(grammarAccess.getUnaryExpressionAccess().getGroup_2(), "rule__UnaryExpression__Group_2__0");
					put(grammarAccess.getEIntAccess().getGroup(), "rule__EInt__Group__0");
					put(grammarAccess.getCellularAutomataInitializationAccess().getGeometryAssignment_1(), "rule__CellularAutomataInitialization__GeometryAssignment_1");
					put(grammarAccess.getCellularAutomataInitializationAccess().getSeedRulesAssignment_2(), "rule__CellularAutomataInitialization__SeedRulesAssignment_2");
					put(grammarAccess.getCellularAutomataInitializationAccess().getSeedRulesAssignment_3(), "rule__CellularAutomataInitialization__SeedRulesAssignment_3");
					put(grammarAccess.getRuleAccess().getFilterAssignment_1(), "rule__Rule__FilterAssignment_1");
					put(grammarAccess.getRuleAccess().getEvaluatedValAssignment_5(), "rule__Rule__EvaluatedValAssignment_5");
					put(grammarAccess.getGlobalPositionAccess().getCoordinateRangesAssignment_2(), "rule__GlobalPosition__CoordinateRangesAssignment_2");
					put(grammarAccess.getGlobalPositionAccess().getCoordinateRangesAssignment_3_1(), "rule__GlobalPosition__CoordinateRangesAssignment_3_1");
					put(grammarAccess.getCoordinateRangeAccess().getLowerCoordinateAssignment_1(), "rule__CoordinateRange__LowerCoordinateAssignment_1");
					put(grammarAccess.getCoordinateRangeAccess().getUpperCoordinateAssignment_3(), "rule__CoordinateRange__UpperCoordinateAssignment_3");
					put(grammarAccess.getPositionLiteralAccess().getDimensionIndexAssignment_3(), "rule__PositionLiteral__DimensionIndexAssignment_3");
					put(grammarAccess.getRegularGeometryAccess().getNeighborsNumberAssignment_2(), "rule__RegularGeometry__NeighborsNumberAssignment_2");
					put(grammarAccess.getRegularGeometryAccess().getDimensionsAssignment_4(), "rule__RegularGeometry__DimensionsAssignment_4");
					put(grammarAccess.getRegularGeometryAccess().getDimensionsAssignment_5_1(), "rule__RegularGeometry__DimensionsAssignment_5_1");
					put(grammarAccess.getDimensionAccess().getSizeAssignment_0_1(), "rule__Dimension__SizeAssignment_0_1");
					put(grammarAccess.getDimensionAccess().getIsCircularAssignment_1_0(), "rule__Dimension__IsCircularAssignment_1_0");
					put(grammarAccess.getDimensionAccess().getSizeAssignment_1_1(), "rule__Dimension__SizeAssignment_1_1");
					put(grammarAccess.getConditionalAccess().getConditionAssignment_1_2(), "rule__Conditional__ConditionAssignment_1_2");
					put(grammarAccess.getConditionalAccess().getIfTrueExpressionAssignment_1_4(), "rule__Conditional__IfTrueExpressionAssignment_1_4");
					put(grammarAccess.getConditionalAccess().getIfFalseExpressionAssignment_1_8(), "rule__Conditional__IfFalseExpressionAssignment_1_8");
					put(grammarAccess.getOrExpressionAccess().getRightAssignment_1_2(), "rule__OrExpression__RightAssignment_1_2");
					put(grammarAccess.getAndExpressionAccess().getRightAssignment_1_2(), "rule__AndExpression__RightAssignment_1_2");
					put(grammarAccess.getEqualExpressionAccess().getRightAssignment_1_2(), "rule__EqualExpression__RightAssignment_1_2");
					put(grammarAccess.getComparisonExpressionAccess().getRightAssignment_1_1(), "rule__ComparisonExpression__RightAssignment_1_1");
					put(grammarAccess.getAddExpressionAccess().getRightAssignment_1_1(), "rule__AddExpression__RightAssignment_1_1");
					put(grammarAccess.getMultExpressionAccess().getRightAssignment_1_1(), "rule__MultExpression__RightAssignment_1_1");
					put(grammarAccess.getUnaryExpressionAccess().getTargetAssignment_1_2(), "rule__UnaryExpression__TargetAssignment_1_2");
					put(grammarAccess.getUnaryExpressionAccess().getTargetAssignment_2_2(), "rule__UnaryExpression__TargetAssignment_2_2");
					put(grammarAccess.getIntegerLiteralAccess().getValAssignment(), "rule__IntegerLiteral__ValAssignment");
				}
			};
		}
		return nameMappings.get(element);
	}
	
	@Override
	protected Collection<FollowElement> getFollowElements(AbstractInternalContentAssistParser parser) {
		try {
			org.kermeta.language.sample.cellularautomata.rules.ui.contentassist.antlr.internal.InternalInitParser typedParser = (org.kermeta.language.sample.cellularautomata.rules.ui.contentassist.antlr.internal.InternalInitParser) parser;
			typedParser.entryRuleCellularAutomataInitialization();
			return typedParser.getFollowElements();
		} catch(RecognitionException ex) {
			throw new RuntimeException(ex);
		}		
	}
	
	@Override
	protected String[] getInitialHiddenTokens() {
		return new String[] { "RULE_WS", "RULE_ML_COMMENT", "RULE_SL_COMMENT" };
	}
	
	public InitGrammarAccess getGrammarAccess() {
		return this.grammarAccess;
	}
	
	public void setGrammarAccess(InitGrammarAccess grammarAccess) {
		this.grammarAccess = grammarAccess;
	}
}
