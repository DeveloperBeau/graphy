namespace CipherLab
{
    public class Config
    {
        public int Iterations { get; set; } = 2000;
        public string SuiteFilter { get; set; } = "all";
        public bool Persist { get; set; } = true;

        public static Config Defaults()
        {
            return new Config();
        }
    }
}
