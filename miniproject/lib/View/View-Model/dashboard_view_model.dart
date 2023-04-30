import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardViewModel with ChangeNotifier {
  final supabase = Supabase.instance.client;
  int utang = 0;
  int pelanggan = 0;

  ///menghitung nilai dari total utang semua pelanggan dari tabel 'transaksi'.
  Future hitungTotalUtang() async {
    int total = 0;
    final List<dynamic> daftarSemuaUtang =
        await supabase.from('transaksi').select('utang');

    for (int i = 0; i < daftarSemuaUtang.length; i++) {
      total += int.parse(daftarSemuaUtang[i]
          .toString()
          .substring(8, daftarSemuaUtang[i].toString().length - 1));
    }
    print(total);
    return total;
  }

  ///menghitung nilai dari total pelanggan yang berutang dari tabel 'pelanggan'.
  Future hitungTotalPelanggan() async {
    final daftarPelanggan = await supabase
        .from('pelanggan')
        .select('*', const FetchOptions(count: CountOption.exact));
    return daftarPelanggan.count;
  }

  ///mengembalikan nilai dari total utang semua pelanggan
  totalUtang() async {
    utang = await hitungTotalUtang();
    notifyListeners();
  }

  ///mengembalikan nilai dari total pelanggan yang berutang
  totalPelanggan() async {
    pelanggan = await hitungTotalPelanggan();
    notifyListeners();
  }
}
