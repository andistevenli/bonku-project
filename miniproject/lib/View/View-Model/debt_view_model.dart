import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DebtViewModel with ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<dynamic> daftarUtang = [];
  int utang = 0;

  ///mendapatkan semua data yang ada pada tabel 'transaksi' berdasarkan id pada tabel 'pelanggan'.
  Future readAllTransactions(int id) async {
    return await supabase
        .from('transaksi')
        .select()
        .eq('id_pelanggan', id)
        .order('id', ascending: false);
  }

  ///mengembalikan data yang ada pada tabel 'transaksi' berdasarkan id pada tabel 'pelanggan'.
  getAllTransactions(int id) async {
    daftarUtang = await readAllTransactions(id);
    notifyListeners();
  }

  ///menghitung nilai dari total utang pada tabel 'transaksi' berdasarkan id pada tabel 'pelanggan'.
  Future hitungTotalUtang(int id) async {
    int total = 0;
    final List<dynamic> daftarSemuaUtang =
        await supabase.from('transaksi').select('utang').eq('id', id);

    for (int i = 0; i < daftarSemuaUtang.length; i++) {
      total += int.parse(daftarSemuaUtang[i]
          .toString()
          .substring(8, daftarSemuaUtang[i].toString().length - 1));
    }
    return total;
  }

  ///mengembalikan nilai dari total utang pada tabel 'transaksi' berdasarkan id pada tabel 'pelanggan'.
  totalUtang(int id) async {
    utang = await hitungTotalUtang(id);
    notifyListeners();
  }
}
