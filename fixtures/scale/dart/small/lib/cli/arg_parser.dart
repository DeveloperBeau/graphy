import '../model/render_options.dart';

RenderOptions parseArgs(List<String> args) {
  var options = RenderOptions();
  for (final arg in args) {
    if (arg.startsWith('--align=')) {
      options = options.copyWith(align: _valueOf(arg));
    } else if (arg.startsWith('--width=')) {
      options = options.copyWith(width: int.parse(_valueOf(arg)));
    } else if (arg.startsWith('--frame=')) {
      options = options.copyWith(frameName: _valueOf(arg));
    }
  }
  return options;
}

String positionalText(List<String> args) {
  return args.where((a) => !a.startsWith('--')).join(' ');
}

String _valueOf(String arg) => arg.substring(arg.indexOf('=') + 1);
