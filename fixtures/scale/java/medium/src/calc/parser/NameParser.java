package calc.parser;

import java.util.ArrayList;
import java.util.List;

import calc.ast.AssignExpr;
import calc.ast.CallExpr;
import calc.ast.Expr;
import calc.ast.VariableExpr;
import calc.lexer.Token;
import calc.lexer.TokenType;

/** Parses what follows an identifier: a call, an assignment, or a bare variable. */
class NameParser {
    static Expr parse(Parser parser, Token name) {
        TokenCursor cursor = parser.cursor;
        if (cursor.accept(TokenType.LPAREN)) {
            List<Expr> args = new ArrayList<>();
            while (!cursor.atType(TokenType.RPAREN)) {
                args.add(parser.parseBinary(Precedence.LOWEST));
                cursor.accept(TokenType.COMMA);
            }
            cursor.advance();
            return new CallExpr(name.getText(), args);
        }
        if (cursor.accept(TokenType.EQUALS)) {
            return new AssignExpr(name.getText(), parser.parseBinary(Precedence.LOWEST));
        }
        return new VariableExpr(name.getText());
    }
}
