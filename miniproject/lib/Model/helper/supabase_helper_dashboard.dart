import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelperDashboard {
  final supabase = Supabase.instance.client;
  List<dynamic> daftarSemuaUtang = [];
  List<dynamic> daftarSemuaPelanggan = [];

  ///menghitung nilai dari total utang semua pelanggan dari tabel 'transaksi'.
  Future<int> readDebtSum() async {
    int utang = 0;
    daftarSemuaUtang = await supabase.from('transaksi').select('utang');
    for (int i = 0; i < daftarSemuaUtang.length; i++) {
      utang += int.parse(daftarSemuaUtang[i]
          .toString()
          .substring(8, daftarSemuaUtang[i].toString().length - 1));
    }
    return utang;
  }

  ///menghitung nilai dari total pelanggan yang berutang dari tabel 'pelanggan'.
  Future<int> readCustomerSum() async {
    daftarSemuaPelanggan = await supabase.from('pelanggan').select();
    final int pelanggan = daftarSemuaPelanggan.length;
    return pelanggan;
  }
}
