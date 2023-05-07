import 'package:intl/intl.dart';

class Formatter {
  final DateFormat formatTanggal = DateFormat('dd MMMM yyyy');
  final NumberFormat formatUang = NumberFormat.simpleCurrency(locale: 'id_ID');
}
