import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelperTransaction {
  final supabase = Supabase.instance.client;

  ///menambahkan utang pada tabel 'transaksi' berdasarkan id pada tabel 'pelanggan'.
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

  ///menghapus data pada tabel 'pelanggan' jika semua utang telah lunas
  Future<void> deleteCustomerAndTransaction(int id) async {
    await supabase.from('transaksi').delete().eq('id_pelanggan', id);
    await supabase.from('pelanggan').delete().eq('id', id);
  }

  ///menghapus data pada tabel 'transaksi'
  Future<void> deleteTransaction(int id) async {
    await supabase.from('transaksi').delete().eq('id', id);
  }

  ///mendapatkan semua data yang ada pada tabel 'transaksi' berdasarkan id pada tabel 'pelanggan'.
  Future<List<dynamic>> read(int id) async {
    return await supabase
        .from('transaksi')
        .select()
        .eq('id_pelanggan', id)
        .order('created_at', ascending: true);
  }

  ///menghitung nilai dari total utang pada tabel 'transaksi' berdasarkan id pada tabel 'pelanggan'.
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
