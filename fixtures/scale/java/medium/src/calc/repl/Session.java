package calc.repl;

import calc.config.Settings;
import calc.eval.Environment;
import calc.eval.FunctionRegistry;
import calc.funcs.BuiltinInstaller;
import calc.history.History;

public class Session {
    private final Environment environment = new Environment();
    private final FunctionRegistry registry = new FunctionRegistry();
    private final History history = new History(200);
    private final Settings settings = new Settings();

    public Session() {
        BuiltinInstaller.install(registry, settings);
    }

    public Environment getEnvironment() {
        return environment;
    }

    public FunctionRegistry getRegistry() {
        return registry;
    }

    public History getHistory() {
        return history;
    }

    public Settings getSettings() {
        return settings;
    }
}
