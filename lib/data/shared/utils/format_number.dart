import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class NumberFormatter {
  static NumberFormat formatter = NumberFormat("#,###.##");

  static String numberFormatter(double value) {
    return formatter.format(value);
  }

  static CurrencyTextInputFormatter formatMoney = CurrencyTextInputFormatter(
    locale: "en",
    decimalDigits: 0,
    symbol: "",
  );
}
