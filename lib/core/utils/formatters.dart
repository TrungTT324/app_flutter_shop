import 'package:intl/intl.dart';

class Formatters {
  static final _currencyFmt = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: '₫',
    decimalDigits: 0,
  );

  static final _dateFmt = DateFormat('dd/MM/yyyy', 'vi_VN');
  static final _dateTimeFmt = DateFormat('HH:mm dd/MM/yyyy', 'vi_VN');

  static String currency(num amount) => _currencyFmt.format(amount);

  static String date(DateTime dt) => _dateFmt.format(dt);

  static String dateTime(DateTime dt) => _dateTimeFmt.format(dt);

  static String compactNumber(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }
}
