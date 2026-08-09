import 'frame.dart';

const asciiFrame = Frame('+', '-', '|');
const roundedFrame = Frame('o', '-', '|');

Frame frameNamed(String name) {
  switch (name) {
    case 'rounded':
      return roundedFrame;
    default:
      return asciiFrame;
  }
}
