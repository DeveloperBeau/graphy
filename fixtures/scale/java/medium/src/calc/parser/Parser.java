package calc.parser;

import java.util.List;

import calc.ast.BinaryExpr;
import calc.ast.Expr;
import calc.lexer.Token;
import calc.lexer.TokenType;

public class Parser {
    final TokenCursor cursor;

    public Parser(List<Token> tokens) {
        this.cursor = new TokenCursor(tokens);
    }

    public Expr parseExpression() {
        Expr root = parseBinary(Precedence.LOWEST);
        cursor.expect(TokenType.END);
        return root;
    }

    Expr parseBinary(int minPrecedence) {
        Expr left = PrimaryParser.parse(this);
        while (Precedence.of(cursor.peek().getType()) > minPrecedence) {
            Token op = cursor.advance();
            left = new BinaryExpr(op.getText().charAt(0), left, parseBinary(Precedence.nextFor(op.getType())));
        }
        return left;
    }
}
