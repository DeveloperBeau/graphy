namespace Calc.Functions
{
    public static class StandardLibrary
    {
        public static FunctionRegistry BuildRegistry()
        {
            var registry = new FunctionRegistry();
            TrigFunctions.Install(registry);
            HyperbolicFunctions.Install(registry);
            LogFunctions.Install(registry);
            PowerFunctions.Install(registry);
            RoundingFunctions.Install(registry);
            StatsFunctions.Install(registry);
            NumberFunctions.Install(registry);
            SequenceFunctions.Install(registry);
            return registry;
        }
    }
}
