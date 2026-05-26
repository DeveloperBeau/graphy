// feature: class inheriting BaseService, implementing IGreeter,
//          using directives (all styles), cross-file call, external call
using System;
using System.Collections.Generic;
using static System.Console;

namespace Graphy
{
    public class Service : BaseService, IGreeter
    {
        private Dictionary<string, string> _cache;

        public Service(string name) : base(name)
        {
            _cache = new Dictionary<string, string>();
        }

        public string Hi()
        {
            return "hello from " + Name;
        }

        public void Run()
        {
            string greeting = Helpers.FormatName(Name);
            Console.WriteLine(greeting);
            void LocalLog(string msg) { Console.Write(msg); }
            LocalLog(greeting);
        }
    }
}
