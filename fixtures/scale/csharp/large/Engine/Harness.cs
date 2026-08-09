using System.Collections.Generic;
using CipherLab.Abstractions;
using CipherLab.Registry;

namespace CipherLab.Engine
{
    public class Harness
    {
        private readonly CorrectnessEngine _correctness = new CorrectnessEngine();

        public List<VectorOutcome> RunAll(ProgressReporter reporter)
        {
            var outcomes = new List<VectorOutcome>();
            foreach (var descriptor in FamilyCatalog.All())
            {
                var outcome = _correctness.Verify(descriptor.Cipher(), descriptor.Vectors());
                reporter.Step(descriptor.Family, outcome.Passed);
                outcomes.Add(outcome);
            }
            return outcomes;
        }
    }
}
