/*
* generated by Xtext
*/
grammar InternalLego;

options {
	superClass=AbstractInternalAntlrParser;
	
}

@lexer::header {
package insa.parser.antlr.internal;

// Hack: Use our own Lexer superclass by means of import. 
// Currently there is no other way to specify the superclass for the lexer.
import org.eclipse.xtext.parser.antlr.Lexer;
}

@parser::header {
package insa.parser.antlr.internal; 

import org.eclipse.xtext.*;
import org.eclipse.xtext.parser.*;
import org.eclipse.xtext.parser.impl.*;
import org.eclipse.emf.ecore.util.EcoreUtil;
import org.eclipse.emf.ecore.EObject;
import org.eclipse.xtext.parser.antlr.AbstractInternalAntlrParser;
import org.eclipse.xtext.parser.antlr.XtextTokenStream;
import org.eclipse.xtext.parser.antlr.XtextTokenStream.HiddenTokens;
import org.eclipse.xtext.parser.antlr.AntlrDatatypeRuleToken;
import insa.services.LegoGrammarAccess;

}

@parser::members {

 	private LegoGrammarAccess grammarAccess;
 	
    public InternalLegoParser(TokenStream input, LegoGrammarAccess grammarAccess) {
        this(input);
        this.grammarAccess = grammarAccess;
        registerRules(grammarAccess.getGrammar());
    }
    
    @Override
    protected String getFirstRuleName() {
    	return "ProgramUnit";	
   	}
   	
   	@Override
   	protected LegoGrammarAccess getGrammarAccess() {
   		return grammarAccess;
   	}
}

@rulecatch { 
    catch (RecognitionException re) { 
        recover(input,re); 
        appendSkippedTokens();
    } 
}




// Entry rule entryRuleProgramUnit
entryRuleProgramUnit returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getProgramUnitRule()); }
	 iv_ruleProgramUnit=ruleProgramUnit 
	 { $current=$iv_ruleProgramUnit.current; } 
	 EOF 
;

// Rule ProgramUnit
ruleProgramUnit returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
(
(
		{ 
	        newCompositeNode(grammarAccess.getProgramUnitAccess().getBlockExpressionParserRuleCall_0()); 
	    }
		lv_block_0_0=ruleExpression		{
	        if ($current==null) {
	            $current = createModelElementForParent(grammarAccess.getProgramUnitRule());
	        }
       		add(
       			$current, 
       			"block",
        		lv_block_0_0, 
        		"Expression");
	        afterParserOrEnumRuleCall();
	    }

)
)*
;





// Entry rule entryRuleExpression
entryRuleExpression returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getExpressionRule()); }
	 iv_ruleExpression=ruleExpression 
	 { $current=$iv_ruleExpression.current; } 
	 EOF 
;

// Rule Expression
ruleExpression returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
(
    { 
        newCompositeNode(grammarAccess.getExpressionAccess().getWhileLoopParserRuleCall_0()); 
    }
    this_WhileLoop_0=ruleWhileLoop
    { 
        $current = $this_WhileLoop_0.current; 
        afterParserOrEnumRuleCall();
    }

    |
    { 
        newCompositeNode(grammarAccess.getExpressionAccess().getNegExpParserRuleCall_1()); 
    }
    this_NegExp_1=ruleNegExp
    { 
        $current = $this_NegExp_1.current; 
        afterParserOrEnumRuleCall();
    }

    |
    { 
        newCompositeNode(grammarAccess.getExpressionAccess().getAndExpParserRuleCall_2()); 
    }
    this_AndExp_2=ruleAndExp
    { 
        $current = $this_AndExp_2.current; 
        afterParserOrEnumRuleCall();
    }

    |
    { 
        newCompositeNode(grammarAccess.getExpressionAccess().getIfBlockParserRuleCall_3()); 
    }
    this_IfBlock_3=ruleIfBlock
    { 
        $current = $this_IfBlock_3.current; 
        afterParserOrEnumRuleCall();
    }

    |
    { 
        newCompositeNode(grammarAccess.getExpressionAccess().getCommandParserRuleCall_4()); 
    }
    this_Command_4=ruleCommand
    { 
        $current = $this_Command_4.current; 
        afterParserOrEnumRuleCall();
    }
)
;





// Entry rule entryRuleBoolExp
entryRuleBoolExp returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getBoolExpRule()); }
	 iv_ruleBoolExp=ruleBoolExp 
	 { $current=$iv_ruleBoolExp.current; } 
	 EOF 
;

// Rule BoolExp
ruleBoolExp returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
(
    { 
        newCompositeNode(grammarAccess.getBoolExpAccess().getNegExpParserRuleCall_0()); 
    }
    this_NegExp_0=ruleNegExp
    { 
        $current = $this_NegExp_0.current; 
        afterParserOrEnumRuleCall();
    }

    |
    { 
        newCompositeNode(grammarAccess.getBoolExpAccess().getAndExpParserRuleCall_1()); 
    }
    this_AndExp_1=ruleAndExp
    { 
        $current = $this_AndExp_1.current; 
        afterParserOrEnumRuleCall();
    }

    |
    { 
        newCompositeNode(grammarAccess.getBoolExpAccess().getHasTurnedCmdParserRuleCall_2()); 
    }
    this_HasTurnedCmd_2=ruleHasTurnedCmd
    { 
        $current = $this_HasTurnedCmd_2.current; 
        afterParserOrEnumRuleCall();
    }

    |
    { 
        newCompositeNode(grammarAccess.getBoolExpAccess().getObstacleCmdParserRuleCall_3()); 
    }
    this_ObstacleCmd_3=ruleObstacleCmd
    { 
        $current = $this_ObstacleCmd_3.current; 
        afterParserOrEnumRuleCall();
    }
)
;





// Entry rule entryRuleWhileLoop
entryRuleWhileLoop returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getWhileLoopRule()); }
	 iv_ruleWhileLoop=ruleWhileLoop 
	 { $current=$iv_ruleWhileLoop.current; } 
	 EOF 
;

// Rule WhileLoop
ruleWhileLoop returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
(	otherlv_0='while' 
    {
    	newLeafNode(otherlv_0, grammarAccess.getWhileLoopAccess().getWhileKeyword_0());
    }
(
(
		{ 
	        newCompositeNode(grammarAccess.getWhileLoopAccess().getLoopCondBoolExpParserRuleCall_1_0()); 
	    }
		lv_loopCond_1_0=ruleBoolExp		{
	        if ($current==null) {
	            $current = createModelElementForParent(grammarAccess.getWhileLoopRule());
	        }
       		set(
       			$current, 
       			"loopCond",
        		lv_loopCond_1_0, 
        		"BoolExp");
	        afterParserOrEnumRuleCall();
	    }

)
)	otherlv_2='do' 
    {
    	newLeafNode(otherlv_2, grammarAccess.getWhileLoopAccess().getDoKeyword_2());
    }
(
(
		{ 
	        newCompositeNode(grammarAccess.getWhileLoopAccess().getBlockExpressionParserRuleCall_3_0()); 
	    }
		lv_block_3_0=ruleExpression		{
	        if ($current==null) {
	            $current = createModelElementForParent(grammarAccess.getWhileLoopRule());
	        }
       		add(
       			$current, 
       			"block",
        		lv_block_3_0, 
        		"Expression");
	        afterParserOrEnumRuleCall();
	    }

)
)*	otherlv_4='end' 
    {
    	newLeafNode(otherlv_4, grammarAccess.getWhileLoopAccess().getEndKeyword_4());
    }
)
;





// Entry rule entryRuleNegExp
entryRuleNegExp returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getNegExpRule()); }
	 iv_ruleNegExp=ruleNegExp 
	 { $current=$iv_ruleNegExp.current; } 
	 EOF 
;

// Rule NegExp
ruleNegExp returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
(	otherlv_0='not' 
    {
    	newLeafNode(otherlv_0, grammarAccess.getNegExpAccess().getNotKeyword_0());
    }
(
(
		{ 
	        newCompositeNode(grammarAccess.getNegExpAccess().getExpBoolExpParserRuleCall_1_0()); 
	    }
		lv_exp_1_0=ruleBoolExp		{
	        if ($current==null) {
	            $current = createModelElementForParent(grammarAccess.getNegExpRule());
	        }
       		set(
       			$current, 
       			"exp",
        		lv_exp_1_0, 
        		"BoolExp");
	        afterParserOrEnumRuleCall();
	    }

)
))
;





// Entry rule entryRuleAndExp
entryRuleAndExp returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getAndExpRule()); }
	 iv_ruleAndExp=ruleAndExp 
	 { $current=$iv_ruleAndExp.current; } 
	 EOF 
;

// Rule AndExp
ruleAndExp returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
(	otherlv_0='and' 
    {
    	newLeafNode(otherlv_0, grammarAccess.getAndExpAccess().getAndKeyword_0());
    }
(
(
		{ 
	        newCompositeNode(grammarAccess.getAndExpAccess().getLeftExpBoolExpParserRuleCall_1_0()); 
	    }
		lv_leftExp_1_0=ruleBoolExp		{
	        if ($current==null) {
	            $current = createModelElementForParent(grammarAccess.getAndExpRule());
	        }
       		set(
       			$current, 
       			"leftExp",
        		lv_leftExp_1_0, 
        		"BoolExp");
	        afterParserOrEnumRuleCall();
	    }

)
)(
(
		{ 
	        newCompositeNode(grammarAccess.getAndExpAccess().getRightExpBoolExpParserRuleCall_2_0()); 
	    }
		lv_rightExp_2_0=ruleBoolExp		{
	        if ($current==null) {
	            $current = createModelElementForParent(grammarAccess.getAndExpRule());
	        }
       		set(
       			$current, 
       			"rightExp",
        		lv_rightExp_2_0, 
        		"BoolExp");
	        afterParserOrEnumRuleCall();
	    }

)
))
;





// Entry rule entryRuleIfBlock
entryRuleIfBlock returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getIfBlockRule()); }
	 iv_ruleIfBlock=ruleIfBlock 
	 { $current=$iv_ruleIfBlock.current; } 
	 EOF 
;

// Rule IfBlock
ruleIfBlock returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
(	otherlv_0='if' 
    {
    	newLeafNode(otherlv_0, grammarAccess.getIfBlockAccess().getIfKeyword_0());
    }
(
(
		{ 
	        newCompositeNode(grammarAccess.getIfBlockAccess().getConditionBoolExpParserRuleCall_1_0()); 
	    }
		lv_condition_1_0=ruleBoolExp		{
	        if ($current==null) {
	            $current = createModelElementForParent(grammarAccess.getIfBlockRule());
	        }
       		set(
       			$current, 
       			"condition",
        		lv_condition_1_0, 
        		"BoolExp");
	        afterParserOrEnumRuleCall();
	    }

)
)	otherlv_2='then' 
    {
    	newLeafNode(otherlv_2, grammarAccess.getIfBlockAccess().getThenKeyword_2());
    }
(
(
		{ 
	        newCompositeNode(grammarAccess.getIfBlockAccess().getThenBlockExpressionParserRuleCall_3_0()); 
	    }
		lv_thenBlock_3_0=ruleExpression		{
	        if ($current==null) {
	            $current = createModelElementForParent(grammarAccess.getIfBlockRule());
	        }
       		add(
       			$current, 
       			"thenBlock",
        		lv_thenBlock_3_0, 
        		"Expression");
	        afterParserOrEnumRuleCall();
	    }

)
)*(	otherlv_4='else' 
    {
    	newLeafNode(otherlv_4, grammarAccess.getIfBlockAccess().getElseKeyword_4_0());
    }
(
(
		{ 
	        newCompositeNode(grammarAccess.getIfBlockAccess().getElseBlockExpressionParserRuleCall_4_1_0()); 
	    }
		lv_elseBlock_5_0=ruleExpression		{
	        if ($current==null) {
	            $current = createModelElementForParent(grammarAccess.getIfBlockRule());
	        }
       		add(
       			$current, 
       			"elseBlock",
        		lv_elseBlock_5_0, 
        		"Expression");
	        afterParserOrEnumRuleCall();
	    }

)
)*)?	otherlv_6='end' 
    {
    	newLeafNode(otherlv_6, grammarAccess.getIfBlockAccess().getEndKeyword_5());
    }
)
;





// Entry rule entryRuleCommand
entryRuleCommand returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getCommandRule()); }
	 iv_ruleCommand=ruleCommand 
	 { $current=$iv_ruleCommand.current; } 
	 EOF 
;

// Rule Command
ruleCommand returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
(
    { 
        newCompositeNode(grammarAccess.getCommandAccess().getMoveCmdParserRuleCall_0()); 
    }
    this_MoveCmd_0=ruleMoveCmd
    { 
        $current = $this_MoveCmd_0.current; 
        afterParserOrEnumRuleCall();
    }

    |
    { 
        newCompositeNode(grammarAccess.getCommandAccess().getPrintCmdParserRuleCall_1()); 
    }
    this_PrintCmd_1=rulePrintCmd
    { 
        $current = $this_PrintCmd_1.current; 
        afterParserOrEnumRuleCall();
    }

    |
    { 
        newCompositeNode(grammarAccess.getCommandAccess().getSetTurnAngleCmdParserRuleCall_2()); 
    }
    this_SetTurnAngleCmd_2=ruleSetTurnAngleCmd
    { 
        $current = $this_SetTurnAngleCmd_2.current; 
        afterParserOrEnumRuleCall();
    }

    |
    { 
        newCompositeNode(grammarAccess.getCommandAccess().getStopEngineCmdParserRuleCall_3()); 
    }
    this_StopEngineCmd_3=ruleStopEngineCmd
    { 
        $current = $this_StopEngineCmd_3.current; 
        afterParserOrEnumRuleCall();
    }

    |
    { 
        newCompositeNode(grammarAccess.getCommandAccess().getStopProgramCmdParserRuleCall_4()); 
    }
    this_StopProgramCmd_4=ruleStopProgramCmd
    { 
        $current = $this_StopProgramCmd_4.current; 
        afterParserOrEnumRuleCall();
    }

    |
    { 
        newCompositeNode(grammarAccess.getCommandAccess().getTurnCmdParserRuleCall_5()); 
    }
    this_TurnCmd_5=ruleTurnCmd
    { 
        $current = $this_TurnCmd_5.current; 
        afterParserOrEnumRuleCall();
    }

    |
    { 
        newCompositeNode(grammarAccess.getCommandAccess().getHasTurnedCmdParserRuleCall_6()); 
    }
    this_HasTurnedCmd_6=ruleHasTurnedCmd
    { 
        $current = $this_HasTurnedCmd_6.current; 
        afterParserOrEnumRuleCall();
    }

    |
    { 
        newCompositeNode(grammarAccess.getCommandAccess().getObstacleCmdParserRuleCall_7()); 
    }
    this_ObstacleCmd_7=ruleObstacleCmd
    { 
        $current = $this_ObstacleCmd_7.current; 
        afterParserOrEnumRuleCall();
    }
)
;







// Entry rule entryRuleHasTurnedCmd
entryRuleHasTurnedCmd returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getHasTurnedCmdRule()); }
	 iv_ruleHasTurnedCmd=ruleHasTurnedCmd 
	 { $current=$iv_ruleHasTurnedCmd.current; } 
	 EOF 
;

// Rule HasTurnedCmd
ruleHasTurnedCmd returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
(	otherlv_0='hasTurned' 
    {
    	newLeafNode(otherlv_0, grammarAccess.getHasTurnedCmdAccess().getHasTurnedKeyword_0());
    }
	otherlv_1='(' 
    {
    	newLeafNode(otherlv_1, grammarAccess.getHasTurnedCmdAccess().getLeftParenthesisKeyword_1());
    }
	otherlv_2='angle' 
    {
    	newLeafNode(otherlv_2, grammarAccess.getHasTurnedCmdAccess().getAngleKeyword_2());
    }
	otherlv_3='=' 
    {
    	newLeafNode(otherlv_3, grammarAccess.getHasTurnedCmdAccess().getEqualsSignKeyword_3());
    }
(
(
		lv_angle_4_0=RULE_DOUBLE
		{
			newLeafNode(lv_angle_4_0, grammarAccess.getHasTurnedCmdAccess().getAngleDOUBLETerminalRuleCall_4_0()); 
		}
		{
	        if ($current==null) {
	            $current = createModelElement(grammarAccess.getHasTurnedCmdRule());
	        }
       		setWithLastConsumed(
       			$current, 
       			"angle",
        		lv_angle_4_0, 
        		"DOUBLE");
	    }

)
)	otherlv_5=')' 
    {
    	newLeafNode(otherlv_5, grammarAccess.getHasTurnedCmdAccess().getRightParenthesisKeyword_5());
    }
)
;





// Entry rule entryRuleMoveCmd
entryRuleMoveCmd returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getMoveCmdRule()); }
	 iv_ruleMoveCmd=ruleMoveCmd 
	 { $current=$iv_ruleMoveCmd.current; } 
	 EOF 
;

// Rule MoveCmd
ruleMoveCmd returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
(	otherlv_0='move' 
    {
    	newLeafNode(otherlv_0, grammarAccess.getMoveCmdAccess().getMoveKeyword_0());
    }
	otherlv_1='(' 
    {
    	newLeafNode(otherlv_1, grammarAccess.getMoveCmdAccess().getLeftParenthesisKeyword_1());
    }
	otherlv_2='power' 
    {
    	newLeafNode(otherlv_2, grammarAccess.getMoveCmdAccess().getPowerKeyword_2());
    }
	otherlv_3='=' 
    {
    	newLeafNode(otherlv_3, grammarAccess.getMoveCmdAccess().getEqualsSignKeyword_3());
    }
(
(
		lv_power_4_0=RULE_DOUBLE
		{
			newLeafNode(lv_power_4_0, grammarAccess.getMoveCmdAccess().getPowerDOUBLETerminalRuleCall_4_0()); 
		}
		{
	        if ($current==null) {
	            $current = createModelElement(grammarAccess.getMoveCmdRule());
	        }
       		setWithLastConsumed(
       			$current, 
       			"power",
        		lv_power_4_0, 
        		"DOUBLE");
	    }

)
)	otherlv_5=')' 
    {
    	newLeafNode(otherlv_5, grammarAccess.getMoveCmdAccess().getRightParenthesisKeyword_5());
    }
)
;





// Entry rule entryRulePrintCmd
entryRulePrintCmd returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getPrintCmdRule()); }
	 iv_rulePrintCmd=rulePrintCmd 
	 { $current=$iv_rulePrintCmd.current; } 
	 EOF 
;

// Rule PrintCmd
rulePrintCmd returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
(	otherlv_0='display' 
    {
    	newLeafNode(otherlv_0, grammarAccess.getPrintCmdAccess().getDisplayKeyword_0());
    }
	otherlv_1='(' 
    {
    	newLeafNode(otherlv_1, grammarAccess.getPrintCmdAccess().getLeftParenthesisKeyword_1());
    }
	otherlv_2='msg' 
    {
    	newLeafNode(otherlv_2, grammarAccess.getPrintCmdAccess().getMsgKeyword_2());
    }
	otherlv_3='=' 
    {
    	newLeafNode(otherlv_3, grammarAccess.getPrintCmdAccess().getEqualsSignKeyword_3());
    }
(
(
		lv_msg_4_0=RULE_STRING
		{
			newLeafNode(lv_msg_4_0, grammarAccess.getPrintCmdAccess().getMsgSTRINGTerminalRuleCall_4_0()); 
		}
		{
	        if ($current==null) {
	            $current = createModelElement(grammarAccess.getPrintCmdRule());
	        }
       		setWithLastConsumed(
       			$current, 
       			"msg",
        		lv_msg_4_0, 
        		"STRING");
	    }

)
)	otherlv_5=',' 
    {
    	newLeafNode(otherlv_5, grammarAccess.getPrintCmdAccess().getCommaKeyword_5());
    }
	otherlv_6='duration' 
    {
    	newLeafNode(otherlv_6, grammarAccess.getPrintCmdAccess().getDurationKeyword_6());
    }
	otherlv_7='=' 
    {
    	newLeafNode(otherlv_7, grammarAccess.getPrintCmdAccess().getEqualsSignKeyword_7());
    }
(
(
		lv_duration_8_0=RULE_INT
		{
			newLeafNode(lv_duration_8_0, grammarAccess.getPrintCmdAccess().getDurationINTTerminalRuleCall_8_0()); 
		}
		{
	        if ($current==null) {
	            $current = createModelElement(grammarAccess.getPrintCmdRule());
	        }
       		setWithLastConsumed(
       			$current, 
       			"duration",
        		lv_duration_8_0, 
        		"INT");
	    }

)
)	otherlv_9=',' 
    {
    	newLeafNode(otherlv_9, grammarAccess.getPrintCmdAccess().getCommaKeyword_9());
    }
	otherlv_10='line' 
    {
    	newLeafNode(otherlv_10, grammarAccess.getPrintCmdAccess().getLineKeyword_10());
    }
	otherlv_11='=' 
    {
    	newLeafNode(otherlv_11, grammarAccess.getPrintCmdAccess().getEqualsSignKeyword_11());
    }
(
(
		lv_line_12_0=RULE_INT
		{
			newLeafNode(lv_line_12_0, grammarAccess.getPrintCmdAccess().getLineINTTerminalRuleCall_12_0()); 
		}
		{
	        if ($current==null) {
	            $current = createModelElement(grammarAccess.getPrintCmdRule());
	        }
       		setWithLastConsumed(
       			$current, 
       			"line",
        		lv_line_12_0, 
        		"INT");
	    }

)
)	otherlv_13=',' 
    {
    	newLeafNode(otherlv_13, grammarAccess.getPrintCmdAccess().getCommaKeyword_13());
    }
	otherlv_14='col' 
    {
    	newLeafNode(otherlv_14, grammarAccess.getPrintCmdAccess().getColKeyword_14());
    }
	otherlv_15='=' 
    {
    	newLeafNode(otherlv_15, grammarAccess.getPrintCmdAccess().getEqualsSignKeyword_15());
    }
(
(
		lv_col_16_0=RULE_INT
		{
			newLeafNode(lv_col_16_0, grammarAccess.getPrintCmdAccess().getColINTTerminalRuleCall_16_0()); 
		}
		{
	        if ($current==null) {
	            $current = createModelElement(grammarAccess.getPrintCmdRule());
	        }
       		setWithLastConsumed(
       			$current, 
       			"col",
        		lv_col_16_0, 
        		"INT");
	    }

)
)	otherlv_17=')' 
    {
    	newLeafNode(otherlv_17, grammarAccess.getPrintCmdAccess().getRightParenthesisKeyword_17());
    }
)
;





// Entry rule entryRuleSetTurnAngleCmd
entryRuleSetTurnAngleCmd returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getSetTurnAngleCmdRule()); }
	 iv_ruleSetTurnAngleCmd=ruleSetTurnAngleCmd 
	 { $current=$iv_ruleSetTurnAngleCmd.current; } 
	 EOF 
;

// Rule SetTurnAngleCmd
ruleSetTurnAngleCmd returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
(	otherlv_0='setTurnAngle' 
    {
    	newLeafNode(otherlv_0, grammarAccess.getSetTurnAngleCmdAccess().getSetTurnAngleKeyword_0());
    }
	otherlv_1='(' 
    {
    	newLeafNode(otherlv_1, grammarAccess.getSetTurnAngleCmdAccess().getLeftParenthesisKeyword_1());
    }
	otherlv_2='angle' 
    {
    	newLeafNode(otherlv_2, grammarAccess.getSetTurnAngleCmdAccess().getAngleKeyword_2());
    }
	otherlv_3='=' 
    {
    	newLeafNode(otherlv_3, grammarAccess.getSetTurnAngleCmdAccess().getEqualsSignKeyword_3());
    }
(
(
		lv_angle_4_0=RULE_DOUBLE
		{
			newLeafNode(lv_angle_4_0, grammarAccess.getSetTurnAngleCmdAccess().getAngleDOUBLETerminalRuleCall_4_0()); 
		}
		{
	        if ($current==null) {
	            $current = createModelElement(grammarAccess.getSetTurnAngleCmdRule());
	        }
       		setWithLastConsumed(
       			$current, 
       			"angle",
        		lv_angle_4_0, 
        		"DOUBLE");
	    }

)
)	otherlv_5=')' 
    {
    	newLeafNode(otherlv_5, grammarAccess.getSetTurnAngleCmdAccess().getRightParenthesisKeyword_5());
    }
)
;





// Entry rule entryRuleStopEngineCmd
entryRuleStopEngineCmd returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getStopEngineCmdRule()); }
	 iv_ruleStopEngineCmd=ruleStopEngineCmd 
	 { $current=$iv_ruleStopEngineCmd.current; } 
	 EOF 
;

// Rule StopEngineCmd
ruleStopEngineCmd returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
((
    {
        $current = forceCreateModelElement(
            grammarAccess.getStopEngineCmdAccess().getStopEngineCmdAction_0(),
            $current);
    }
)	otherlv_1='stopEngine' 
    {
    	newLeafNode(otherlv_1, grammarAccess.getStopEngineCmdAccess().getStopEngineKeyword_1());
    }
)
;





// Entry rule entryRuleStopProgramCmd
entryRuleStopProgramCmd returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getStopProgramCmdRule()); }
	 iv_ruleStopProgramCmd=ruleStopProgramCmd 
	 { $current=$iv_ruleStopProgramCmd.current; } 
	 EOF 
;

// Rule StopProgramCmd
ruleStopProgramCmd returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
((
    {
        $current = forceCreateModelElement(
            grammarAccess.getStopProgramCmdAccess().getStopProgramCmdAction_0(),
            $current);
    }
)	otherlv_1='stopProgram' 
    {
    	newLeafNode(otherlv_1, grammarAccess.getStopProgramCmdAccess().getStopProgramKeyword_1());
    }
)
;





// Entry rule entryRuleTurnCmd
entryRuleTurnCmd returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getTurnCmdRule()); }
	 iv_ruleTurnCmd=ruleTurnCmd 
	 { $current=$iv_ruleTurnCmd.current; } 
	 EOF 
;

// Rule TurnCmd
ruleTurnCmd returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
(	otherlv_0='turn' 
    {
    	newLeafNode(otherlv_0, grammarAccess.getTurnCmdAccess().getTurnKeyword_0());
    }
	otherlv_1='(' 
    {
    	newLeafNode(otherlv_1, grammarAccess.getTurnCmdAccess().getLeftParenthesisKeyword_1());
    }
	otherlv_2='power' 
    {
    	newLeafNode(otherlv_2, grammarAccess.getTurnCmdAccess().getPowerKeyword_2());
    }
	otherlv_3='=' 
    {
    	newLeafNode(otherlv_3, grammarAccess.getTurnCmdAccess().getEqualsSignKeyword_3());
    }
(
(
		lv_power_4_0=RULE_DOUBLE
		{
			newLeafNode(lv_power_4_0, grammarAccess.getTurnCmdAccess().getPowerDOUBLETerminalRuleCall_4_0()); 
		}
		{
	        if ($current==null) {
	            $current = createModelElement(grammarAccess.getTurnCmdRule());
	        }
       		setWithLastConsumed(
       			$current, 
       			"power",
        		lv_power_4_0, 
        		"DOUBLE");
	    }

)
)	otherlv_5=',' 
    {
    	newLeafNode(otherlv_5, grammarAccess.getTurnCmdAccess().getCommaKeyword_5());
    }
	otherlv_6='angle' 
    {
    	newLeafNode(otherlv_6, grammarAccess.getTurnCmdAccess().getAngleKeyword_6());
    }
	otherlv_7='=' 
    {
    	newLeafNode(otherlv_7, grammarAccess.getTurnCmdAccess().getEqualsSignKeyword_7());
    }
(
(
		lv_angle_8_0=RULE_DOUBLE
		{
			newLeafNode(lv_angle_8_0, grammarAccess.getTurnCmdAccess().getAngleDOUBLETerminalRuleCall_8_0()); 
		}
		{
	        if ($current==null) {
	            $current = createModelElement(grammarAccess.getTurnCmdRule());
	        }
       		setWithLastConsumed(
       			$current, 
       			"angle",
        		lv_angle_8_0, 
        		"DOUBLE");
	    }

)
)	otherlv_9=')' 
    {
    	newLeafNode(otherlv_9, grammarAccess.getTurnCmdAccess().getRightParenthesisKeyword_9());
    }
)
;





// Entry rule entryRuleObstacleCmd
entryRuleObstacleCmd returns [EObject current=null] 
	:
	{ newCompositeNode(grammarAccess.getObstacleCmdRule()); }
	 iv_ruleObstacleCmd=ruleObstacleCmd 
	 { $current=$iv_ruleObstacleCmd.current; } 
	 EOF 
;

// Rule ObstacleCmd
ruleObstacleCmd returns [EObject current=null] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
(	otherlv_0='obstacle' 
    {
    	newLeafNode(otherlv_0, grammarAccess.getObstacleCmdAccess().getObstacleKeyword_0());
    }
	otherlv_1='(' 
    {
    	newLeafNode(otherlv_1, grammarAccess.getObstacleCmdAccess().getLeftParenthesisKeyword_1());
    }
	otherlv_2='distance' 
    {
    	newLeafNode(otherlv_2, grammarAccess.getObstacleCmdAccess().getDistanceKeyword_2());
    }
	otherlv_3='=' 
    {
    	newLeafNode(otherlv_3, grammarAccess.getObstacleCmdAccess().getEqualsSignKeyword_3());
    }
(
(
		lv_distance_4_0=RULE_DOUBLE
		{
			newLeafNode(lv_distance_4_0, grammarAccess.getObstacleCmdAccess().getDistanceDOUBLETerminalRuleCall_4_0()); 
		}
		{
	        if ($current==null) {
	            $current = createModelElement(grammarAccess.getObstacleCmdRule());
	        }
       		setWithLastConsumed(
       			$current, 
       			"distance",
        		lv_distance_4_0, 
        		"DOUBLE");
	    }

)
)	otherlv_5=')' 
    {
    	newLeafNode(otherlv_5, grammarAccess.getObstacleCmdAccess().getRightParenthesisKeyword_5());
    }
)
;





// Entry rule entryRuleBOOLEAN_LITERAL
entryRuleBOOLEAN_LITERAL returns [String current=null] 
	:
	{ newCompositeNode(grammarAccess.getBOOLEAN_LITERALRule()); } 
	 iv_ruleBOOLEAN_LITERAL=ruleBOOLEAN_LITERAL 
	 { $current=$iv_ruleBOOLEAN_LITERAL.current.getText(); }  
	 EOF 
;

// Rule BOOLEAN_LITERAL
ruleBOOLEAN_LITERAL returns [AntlrDatatypeRuleToken current=new AntlrDatatypeRuleToken()] 
    @init { enterRule(); 
    }
    @after { leaveRule(); }:
(
	kw='true' 
    {
        $current.merge(kw);
        newLeafNode(kw, grammarAccess.getBOOLEAN_LITERALAccess().getTrueKeyword_0()); 
    }

    |
	kw='false' 
    {
        $current.merge(kw);
        newLeafNode(kw, grammarAccess.getBOOLEAN_LITERALAccess().getFalseKeyword_1()); 
    }
)
    ;





RULE_STRING : ('"' ('\\' ('b'|'t'|'n'|'f'|'r'|'u'|'"'|'\''|'\\')|~(('\\'|'"')))* '"'|'\'' ('\\' ('b'|'t'|'n'|'f'|'r'|'u'|'"'|'\''|'\\')|~(('\\'|'\'')))* '\'');

RULE_ML_COMMENT : '/*' ( options {greedy=false;} : . )*'*/';

RULE_SL_COMMENT : '//' ~(('\n'|'\r'))* ('\r'? '\n')?;

RULE_WS : (' '|'\t'|'\r'|'\n')+;

fragment RULE_DIGIT : '0'..'9';

RULE_DOUBLE : RULE_INT '.' RULE_DIGIT*;

RULE_INT : ('0'|'1'..'9' RULE_DIGIT*);


