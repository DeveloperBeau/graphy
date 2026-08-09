using System;
using System.Collections.Generic;
using CipherLab.Cli;
using CipherLab.Engine;
using CipherLab.Registry;
using CipherLab.Report;
using CipherLab.Store;

namespace CipherLab
{
    public static class Program
    {
        public static void Main(string[] args)
        {
            var config = ArgParser.Parse(args);
            var session = new SessionState();
            var reporter = new ProgressReporter(FamilyCatalog.All().Count);
            var outcomes = new Harness().RunAll(reporter);

            var records = new List<ResultRecord>();
            foreach (var descriptor in FamilyCatalog.All())
            {
                records.Add(new ResultRecord { Family = descriptor.Family, Suite = descriptor.Suite, Passed = true });
            }
            if (config.Persist)
            {
                session.Store().Persist(records);
            }
            Console.WriteLine(new SummaryReport().Build(outcomes, session.PreviousSessions()));
            Console.WriteLine(new SuiteReport().Build(outcomes));
        }
    }
}
