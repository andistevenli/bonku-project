import 'package:flutter/material.dart';
import 'package:miniproject/Model/customer_model.dart';
import 'package:miniproject/Model/helper/supabase_helper_customer.dart';

class CustomerViewModel with ChangeNotifier {
  List<dynamic> pelanggan = [];
  List<CustomerModel>? daftarPelanggan;

  final SupabaseHelperCustomer _supabaseHelperCustomer =
      SupabaseHelperCustomer();

  ///mengembalikan data yang ada pada tabel 'pelanggan'.
  Future<List<CustomerModel>> getAllCustomers() async {
    pelanggan = await _supabaseHelperCustomer.read();
    daftarPelanggan = [];
    for (var element in pelanggan) {
      daftarPelanggan!.add(CustomerModel.fromJson(element));
    }
    return daftarPelanggan!;
  }

  Future<void> readCustomers() async {
    daftarPelanggan = await getAllCustomers();
    notifyListeners();
  }

  Future<void> createCustomer(
      String nama, int batasUtang, String deskripsi, int utang) async {
    await _supabaseHelperCustomer.create(nama, batasUtang, deskripsi, utang);
    notifyListeners();
  }

  Future<void> updateCustomer(int id, String nama, int batasUtang) async {
    await _supabaseHelperCustomer.update(id, nama, batasUtang);
    notifyListeners();
  }

  Future<void> deleteCustomer(int id) async {
    await _supabaseHelperCustomer.delete(id);
    notifyListeners();
  }
}
