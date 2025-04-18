import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

extension StringExtension on String? {
  bool get isEmptyOrNullValue =>
      this == null || this!.trim().isEmpty || this == "null";

  bool get isValidPassword =>
      !isEmptyOrNullValue &&
      RegExp(r'^(?!^0+$)[a-zA-Z0-9]{8,12}$').hasMatch(this!);

  bool get isValidEmail =>
      !isEmptyOrNullValue &&
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
          .hasMatch(this!);

  bool get isValidPhone =>
      !isEmptyOrNullValue && RegExp(r"^[6-9]\d{9}$").hasMatch(this!);

  bool get isDouble => double.tryParse(this ?? '') != null;

  int? get toIntOrNull => isEmptyOrNullValue ? null : int.tryParse(this!);

  double? get toDoubleOrNull =>
      isEmptyOrNullValue ? null : double.tryParse(this!);

  double get toDoubleOrZero => toDoubleOrNull ?? 0.0;

  String get capitalizeFirstOrEmpty =>
      isEmptyOrNullValue ? "" : this![0].toUpperCase() + this!.substring(1);

  String get orEmpty => this ?? '';

  String? get nullIfEmpty => isEmptyOrNullValue ? null : this;

  String get toCurrencyAmount => "$defaultCurrencySymbol${validate()}";

  String get capitalizeFirstInStringOrEmpty {
    if (isEmptyOrNullValue) return "";
    return this![0].toUpperCase() + this!.substring(1);
  }

  /// Converts string to Title Case
  String get toTitleCase => isEmptyOrNullValue
      ? ""
      : this!
          .split(" ")
          .map((word) => word.isEmpty
              ? ""
              : word[0].toUpperCase() + word.substring(1).toLowerCase())
          .join(" ");

  /// Masks sensitive info (e.g., emails, phone numbers)
  String get maskSensitiveInfo {
    if (isValidEmail) {
      final parts = this!.split('@');
      return '${parts[0].substring(0, 2)}****@${parts[1]}';
    } else if (isValidPhone) {
      return '${this!.substring(0, 2)}******${this!.substring(this!.length - 2)}';
    }
    return this ?? "";
  }

  /// Truncates the string to a given length and adds "..." if needed
  String truncate(int maxLength) {
    if (isEmptyOrNullValue || this!.length <= maxLength) return this ?? "";
    return '${this!.substring(0, maxLength)}...';
  }

  DateTime? get toFormatDateTryParse {
    if (isEmptyOrNullValue) return null;
    return DateFormat('dd MMM yyyy').tryParse(this!);
  }

  DateTime? get toDateTime {
    if (isEmptyOrNullValue) return null;
    return DateTime.tryParse(this!);
  }
}
