using Calc.Eval;

namespace Calc
{
    public class Settings
    {
        public int Precision { get; set; } = 6;
        public AngleMode Angle { get; set; } = AngleMode.Radians;
        public bool Running { get; set; } = true;

        public static Settings Interactive()
        {
            return new Settings();
        }
    }
}
