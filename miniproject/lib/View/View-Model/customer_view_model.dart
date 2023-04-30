import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerViewModel with ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<dynamic>? daftarPelanggan;

  ///menambahkan data ke tabel 'pelanggan' dan tabel 'transaksi'.
  addCustomer(
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
    notifyListeners();
  }

  ///memperbaharui data pada tabel 'pelanggan'
  changeCustomer(int id, String nama, int batasUtang) async {
    await supabase.from('pelanggan').update({
      'nama': nama,
      'batas_utang': batasUtang,
    }).eq('id', id);
    notifyListeners();
  }

  ///menghapus data pada tabel 'pelanggan'
  deleteCustomer(int id) async {
    await supabase.from('transaksi').delete().eq('id_pelanggan', id);
    await supabase.from('pelanggan').delete().eq('id', id);
    notifyListeners();
  }

  ///mendapatkan semua id dari tabel 'pelanggan'.
  Future captureAllId() async {
    final List<dynamic> daftarId =
        await supabase.from('pelanggan').select('id');
    return daftarId;
  }

  ///mendapatkan id terakhir dari tabel 'pelanggan'.
  getLastId() async {
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

  ///mendapatkan semua data yang ada pada tabel 'pelanggan'.
  Future readAllCustomers() async {
    return await supabase
        .from('pelanggan')
        .select()
        .order('created_at', ascending: false);
  }

  ///mengembalikan data yang ada pada tabel 'pelanggan'.
  getAllCustomers() async {
    daftarPelanggan = await readAllCustomers();
    notifyListeners();
  }
}
