import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardViewModel with ChangeNotifier {
  final supabase = Supabase.instance.client;

  Future hitungTotalUtang() async {
    int total = 0;
    final List<dynamic> daftarSemuaUtang =
        await supabase.from('transaksi').select('utang');
    for (int i = 0; i < daftarSemuaUtang.length; i++) {
      total += int.parse(daftarSemuaUtang[i]
          .toString()
          .substring(8, daftarSemuaUtang[i].toString().length - 1));
    }
    return total;
  }

  Future hitungTotalPelanggan() async {
    final daftarPelanggan = await supabase
        .from('pelanggan')
        .select('*', const FetchOptions(count: CountOption.exact));
    return daftarPelanggan.count;
  }

  ///mengembalikan nilai dari total utang semua pelanggan
  totalUtang() async {
    final total = await hitungTotalUtang();
    return total;
  }

  ///mengembalikan nilai dari total pelanggan yang berutang
  totalPelanggan() async {
    final total = await hitungTotalPelanggan();
    return total;
  }
}
