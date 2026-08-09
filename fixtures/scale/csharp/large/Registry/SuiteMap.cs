using System.Collections.Generic;
using System.Linq;
using CipherLab.Abstractions;

namespace CipherLab.Registry
{
    public static class SuiteMap
    {
        public static Dictionary<string, List<IFamilyDescriptor>> Grouped()
        {
            var map = new Dictionary<string, List<IFamilyDescriptor>>();
            foreach (var descriptor in FamilyCatalog.All())
            {
                if (!map.ContainsKey(descriptor.Suite))
                {
                    map[descriptor.Suite] = new List<IFamilyDescriptor>();
                }
                map[descriptor.Suite].Add(descriptor);
            }
            return map;
        }

        public static List<string> SuiteNames()
        {
            return Grouped().Keys.OrderBy(name => name).ToList();
        }
    }
}
