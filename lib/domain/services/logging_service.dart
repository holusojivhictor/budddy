/// A simple service for producing custom logs.
abstract class LoggingService {
  /// Log a message at the info level.
  void info(Type type, String msg, [List<Object>? args]);

  /// Log a message at the warning level.
  void warning(Type type, String msg, [dynamic ex, StackTrace? trace]);

  /// Log a message at the error level.
  void error(Type type, String msg, [dynamic ex, StackTrace? trace]);
}
