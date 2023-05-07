import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelperTransaction {
  final supabase = Supabase.instance.client;

  ///method create record ke tabel 'transaksi'.
  Future<void> create(
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

  ///method delete record pada tabel 'transaksi' dan pada tabel 'pelanggan'.
  Future<void> deleteCustomerAndTransaction(int id) async {
    await supabase.from('transaksi').delete().eq('id_pelanggan', id);
    await supabase.from('pelanggan').delete().eq('id', id);
  }

  ///method delete record pada tabel 'transaksi'.
  Future<void> deleteTransaction(int id) async {
    await supabase.from('transaksi').delete().eq('id', id);
  }

  ///method read semua record pada tabel 'transaksi' berdasarkan kolom id_pelanggan.
  Future<List<dynamic>> read(int id) async {
    return await supabase
        .from('transaksi')
        .select()
        .eq('id_pelanggan', id)
        .order('created_at', ascending: true);
  }

  ///untuk mendapatkan total utang berdasarkan kolom id_pelanggan pada tabel 'transaksi'.
  Future sum(int id) async {
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
}
