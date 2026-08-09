package calc.ast;

import java.util.List;

public class CallExpr implements Expr {
    private final String function;
    private final List<Expr> arguments;

    public CallExpr(String function, List<Expr> arguments) {
        this.function = function;
        this.arguments = arguments;
    }

    public String getFunction() {
        return function;
    }

    public List<Expr> getArguments() {
        return arguments;
    }

    @Override
    public String describe() {
        return function + "/" + arguments.size();
    }
}
