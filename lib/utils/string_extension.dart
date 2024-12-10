import 'package:intl/intl.dart';

extension DateFormatting on String {
  String toCustomDateFormat() {
    try {
      // Parse the string to a DateTime object
      final dateTime = DateTime.parse(this);

      // Format the DateTime object to the desired format
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      // Handle parsing error
      return "Invalid Date";
    }
  }
}
