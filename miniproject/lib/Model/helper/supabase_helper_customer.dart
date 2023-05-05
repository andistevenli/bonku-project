import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelperCustomer {
  final supabase = Supabase.instance.client;

  ///menambahkan data ke tabel 'pelanggan' dan tabel 'transaksi'.
  Future<void> create(
    String nama,
    int batasUtang,
    String deskripsi,
    int utang,
  ) async {
    final id = await getLastId();
    await supabase.from('pelanggan').insert({
      'id': id,
      'nama': nama,
      'batas_utang': batasUtang,
    });
    await supabase.from('transaksi').insert({
      'deskripsi': deskripsi,
      'utang': utang,
      'id_pelanggan': id,
    });
  }

  ///memperbaharui data pada tabel 'pelanggan'
  Future<void> update(int id, String nama, int batasUtang) async {
    await supabase.from('pelanggan').update({
      'nama': nama,
      'batas_utang': batasUtang,
    }).eq('id', id);
  }

  ///menghapus data pada tabel 'pelanggan'
  Future<void> delete(int id) async {
    await supabase.from('transaksi').delete().eq('id_pelanggan', id);
    await supabase.from('pelanggan').delete().eq('id', id);
  }

  ///mendapatkan semua data yang ada pada tabel 'pelanggan'.
  Future<List<dynamic>> read() async {
    return await supabase
        .from('pelanggan')
        .select()
        .order('created_at', ascending: false);
  }

  ///mendapatkan semua id dari tabel 'pelanggan'.
  Future<List<dynamic>> captureAllId() async {
    final List<dynamic> daftarId =
        await supabase.from('pelanggan').select('id');
    return daftarId;
  }

  ///mendapatkan id terakhir dari tabel 'pelanggan'.
  Future<int> getLastId() async {
    List<dynamic> daftarId = await captureAllId();
    int lastId = 0;
    if (daftarId.isEmpty) {
      lastId++;
      return lastId;
    } else {
      lastId = int.parse(daftarId.last
          .toString()
          .substring(5, daftarId.last.toString().length - 1));
      lastId++;
      return lastId;
    }
  }
}
