// feature: class, interface, struct, record, enum
using System;

namespace Graphy
{
    public interface IGreeter
    {
        string Hi();
    }

    public enum State { Idle, Running, Done }

    public record Point(int X, int Y);

    public struct Dimensions
    {
        public int Width;
        public int Height;
    }

    public class BaseService
    {
        protected string Name;
        public BaseService(string name) { Name = name; }
    }
}
