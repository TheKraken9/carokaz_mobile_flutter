import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'fr',
      symbol: 'Ar',
      decimalDigits: 0,
    ).format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    //+261 34 12 345 67
    if (phoneNumber.length == 10) {
      return '+261 ${phoneNumber.substring(3)}';
    }
    return phoneNumber;
  }

  static String internationalFormatPhoneNumber(String phoneNumber) {
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    String countryCode = '+${digitsOnly.substring(0, 3)}';
    digitsOnly = digitsOnly.substring(3);

    final formattedNumber = StringBuffer();
    formattedNumber.write(countryCode);

    int i=0;
    while(i < digitsOnly.length) {
      int groupLength = 3;
      if(i + groupLength > digitsOnly.length) {
        groupLength = digitsOnly.length - i;
      }

      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if(end < digitsOnly.length) {
        formattedNumber.write(' ');
      }

      i = end;
    }
    return formattedNumber.toString();
  }
}