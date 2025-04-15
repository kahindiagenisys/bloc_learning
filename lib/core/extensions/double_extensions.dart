import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

extension DoubleFormattingExtensions on double? {

  /// Returns an empty string if the number is null or zero or less; otherwise, returns the string representation.
  String get asStringOrEmpty {
    if (this == null || this! <= 0) return "";
    return toString();
  }

  /// Returns a formatted string representation of the number with compact formatting for large numbers or fixed 2 decimal places.
  String get formattedNumber {
    if (this == null) return "0.00";
    return this! > 9999
        ? NumberFormat.compact().format(this)
        : this!.toStringAsFixed(2);
  }

  /// Returns a formatted string with the currency format (with commas and decimals where applicable).
  String get formattedCurrency {
    final format = (this ?? 0) % 1 == 0 ? "#,##0" : "#,##0.00";
    return NumberFormat(format, 'en_US').format(this);
  }

  /// Returns a string representation of the number without decimals if the number is an integer, else with up to 3 decimal places.
  String toStringWithoutDecimals() {
    final format = (this ?? 0) % 1 == 0 ? "0" : "0.###"; // up to 3 decimal places
    return NumberFormat(format).format(this);
  }

  /// Returns the number as a string with only necessary decimals, removing trailing zeros.
  String get formattedDecimal {
    String formatted = (this ?? 0).toStringAsFixed(2);
    RegExp regExp = RegExp(r"([.]*0+)(?!.*\d)");
    return formatted.replaceAll(regExp, '');
  }

  /// Returns the formatted decimal value as a string or an empty string if the number is null or zero or less.
  String get formattedDecimalOrEmpty {
    if (this == null || this! <= 0) return '';
    String formatted = this!.toStringAsFixed(2);
    RegExp regExp = RegExp(r"([.]*0+)(?!.*\d)");
    return formatted.replaceAll(regExp, '');
  }

  /// Returns the number formatted to 2 decimal places, removing trailing zeros as needed, and converts it back to a double.
  double get formattedDecimalAsDouble {
    String formatted = (this ?? 0).toStringAsFixed(2);
    RegExp regExp = RegExp(r"([.]*0+)(?!.*\d)");
    return double.parse(formatted.replaceAll(regExp, ''));
  }

  /// Returns the number as a currency amount, using the default currency symbol and formatted decimals.
  String get toCurrencyAmountOrString =>
      "$defaultCurrencySymbol ${formattedDecimalOrEmpty.validate()}";
}
