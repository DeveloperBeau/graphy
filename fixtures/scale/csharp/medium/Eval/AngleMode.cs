using System;

namespace Calc.Eval
{
    public enum AngleMode
    {
        Radians,
        Degrees
    }

    public static class AngleConvert
    {
        public static double ToRadians(double value, AngleMode mode)
        {
            return mode == AngleMode.Degrees ? value * Math.PI / 180.0 : value;
        }
    }
}
