<?php

namespace Calc\Eval;

use Calc\Ast\Assignment;
use Calc\Ast\BinaryOp;
use Calc\Ast\FunctionCall;
use Calc\Ast\Node;
use Calc\Ast\NumberLiteral;
use Calc\Ast\UnaryOp;
use Calc\Ast\VariableRef;
use Calc\Functions\FunctionRegistry;

require_once __DIR__ . '/BinaryMath.php';

class Evaluator
{
    public function __construct(private Environment $environment, private FunctionRegistry $functions) {}

    public function eval(Node $node): float
    {
        $args = fn (FunctionCall $n) => array_map(fn (Node $a) => $this->eval($a), $n->arguments);
        return match (true) {
            $node instanceof NumberLiteral => $node->value,
            $node instanceof VariableRef => $this->environment->resolve($node->name),
            $node instanceof UnaryOp => -$this->eval($node->operand),
            $node instanceof BinaryOp => BinaryMath::apply($node->op, $this->eval($node->left), $this->eval($node->right)),
            $node instanceof FunctionCall => $this->functions->invoke($node->name, $args($node)),
            $node instanceof Assignment => $this->assign($node),
            default => throw new EvalError('unsupported node', $node->describe()),
        };
    }

    private function assign(Assignment $node): float
    {
        $value = $this->eval($node->value);
        $this->environment->assign($node->name, $value);
        return $value;
    }
}
