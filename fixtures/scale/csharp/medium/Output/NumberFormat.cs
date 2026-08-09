using System.Globalization;

namespace Calc.Output
{
    public static class NumberFormat
    {
        public static string Format(double value, int precision)
        {
            if (double.IsNaN(value) || double.IsInfinity(value))
            {
                return value.ToString(CultureInfo.InvariantCulture);
            }
            var rounded = System.Math.Round(value, precision);
            return rounded.ToString("0." + new string('#', precision), CultureInfo.InvariantCulture);
        }
    }
}
