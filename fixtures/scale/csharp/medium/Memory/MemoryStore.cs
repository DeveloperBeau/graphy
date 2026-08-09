namespace Calc.Memory
{
    public class MemoryStore
    {
        private double _slot;

        public void Store(double value)
        {
            _slot = value;
        }

        public double Recall()
        {
            return _slot;
        }

        public void Accumulate(double value)
        {
            _slot += value;
        }

        public void Clear()
        {
            _slot = 0;
        }
    }
}
