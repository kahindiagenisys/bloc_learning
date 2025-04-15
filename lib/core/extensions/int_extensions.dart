import 'package:intl/intl.dart';

extension IntExtension on int? {

  /// Returns an empty string if the number is null; otherwise, returns the string representation.
  String get asStringOrEmpty {
    return this?.toString() ?? "";
  }

  /// Formats the integer to a compact format if it's greater than 9999; otherwise, returns the number as a string.
  String get formattedNumber {
    if (this == null) return "0";
    return this! > 9999 ? NumberFormat.compact().format(this) : this.toString();
  }
}
