import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

Logger getLogger(String origin) => Logger(printer: AppPrinter(origin));

class AppPrinter extends PrettyPrinter {
  final String origin;

  static final RegExp fileNameRegex = RegExp(r'\(.*\/(.*)\)');

  AppPrinter(this.origin);

  @override
  void log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];
    //final emoji = PrettyPrinter.levelColors[event.level];

    String trace;
    if (event.stackTrace == null) {
      trace = getOriginLine(StackTrace.current);
    } else {
      trace = getOriginLine(event.stackTrace);
    }
    final time = DateFormat.Hms().format(DateTime.now());
    final levelStr = event.level.toString().split('.')[1];
    final originFile = getOriginFileName(trace);
    println(
        color('[$time] $levelStr | $origin - ${event.message} ($originFile)'));

    if (event.level.index >= Level.warning.index) println(color(trace));
  }

  String getOriginFileName(String line) {
    final m = fileNameRegex.firstMatch(line);
    return m.group(1);
  }

  String getOriginLine(StackTrace stackTrace) {
    var lines = stackTrace.toString().split("\n").skip(1).toList();
    for (var line in lines) {
      var match = PrettyPrinter.stackTraceRegex.matchAsPrefix(line);
      if (match != null) {
        if (match.group(2).startsWith('package:logger')) {
          continue;
        }
        var newLine = (" > ${match.group(1)} (${match.group(2)})");
        return newLine.replaceAll('<anonymous closure>', '()');
      } else {
        return line;
      }
    }

    return null;
  }
}
