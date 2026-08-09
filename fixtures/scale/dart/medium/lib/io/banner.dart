const _version = '2.1.0';

String banner() {
  final sb = StringBuffer();
  sb.writeln('mathwork $_version');
  sb.write('type an expression, :help for commands, :quit to exit');
  return sb.toString();
}
