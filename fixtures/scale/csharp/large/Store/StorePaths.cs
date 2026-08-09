using System;
using System.IO;

namespace CipherLab.Store
{
    public static class StorePaths
    {
        public static string StoreDir()
        {
            return Path.Combine(Directory.GetCurrentDirectory(), ".cipherlab");
        }

        public static string ResultsFile()
        {
            return Path.Combine(StoreDir(), "results.jsonl");
        }

        public static void EnsureDir()
        {
            Directory.CreateDirectory(StoreDir());
        }
    }
}
