import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DebtViewModel with ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<dynamic>? daftarUtang;
  int? utang;

  ///mendapatkan semua data yang ada pada tabel 'transaksi' berdasarkan id pada tabel 'pelanggan'.
  Future readAllTransactions(int id) async {
    return await supabase
        .from('transaksi')
        .select()
        .eq('id_pelanggan', id)
        .order('created_at', ascending: false);
  }

  ///menghapus data pada tabel 'pelanggan' jika semua utang telah lunas
  deleteCustomerIfNoDebtAnymore(int id) async {
    await supabase.from('pelanggan').delete().eq('id', id);
    notifyListeners();
  }

  ///mengembalikan data yang ada pada tabel 'transaksi' berdasarkan id pada tabel 'pelanggan'.
  getAllTransactions(int id) async {
    daftarUtang = await readAllTransactions(id);
    notifyListeners();
  }

  ///menghitung nilai dari total utang pada tabel 'transaksi' berdasarkan id pada tabel 'pelanggan'.
  Future hitungTotalUtang(int id) async {
    int total = 0;
    final List<dynamic> daftarSemuaUtangPerId =
        await supabase.from('transaksi').select('utang').eq('id_pelanggan', id);
    for (int i = 0; i < daftarSemuaUtangPerId.length; i++) {
      total += int.parse(daftarSemuaUtangPerId[i]
          .toString()
          .substring(8, daftarSemuaUtangPerId[i].toString().length - 1));
    }
    return total;
  }

  ///mengembalikan nilai dari total utang pada tabel 'transaksi' berdasarkan id pada tabel 'pelanggan'.
  totalUtang(int id) async {
    utang = await hitungTotalUtang(id);
    notifyListeners();
  }

  ///menambahkan utang pada tabel 'transaksi' berdasarkan id pada tabel 'pelanggan'.
  addDebt(
    int idPelanggan,
    String deskripsi,
    int utang,
  ) async {
    await supabase.from('transaksi').insert({
      'deskripsi': deskripsi,
      'utang': utang,
      'id_pelanggan': idPelanggan,
    });
  }

  ///menghapus data pada tabel 'transaksi'
  deleteDebt(int id) async {
    await supabase.from('transaksi').delete().eq('id_pelanggan', id);
    notifyListeners();
  }
}
