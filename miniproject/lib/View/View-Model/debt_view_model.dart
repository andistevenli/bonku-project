import 'package:flutter/material.dart';
import 'package:miniproject/Model/formatter.dart';
import 'package:miniproject/Model/helper/supabase_helper_transaction.dart';
import 'package:miniproject/Model/transaction_model.dart';

class DebtViewModel with ChangeNotifier {
  final Formatter myFormatter = Formatter();
  List<dynamic> utang = [];
  List<TransactionModel>? daftarUtang;
  int totalUtang = 0;

  final SupabaseHelperTransaction _supabaseHelperTransaction =
      SupabaseHelperTransaction();

  //prosedur menambahkan utang pada pelanggan yang dipilih.
  Future<void> createDebt(int idPelanggan, String deskripsi, int utang) async {
    await _supabaseHelperTransaction.create(idPelanggan, deskripsi, utang);
    notifyListeners();
  }

  ///mendapatkan daftar utang dan mengembalikan daftar utang per masing-masing pelanggan.
  Future<List<TransactionModel>> getAllDebt(int id) async {
    utang = await _supabaseHelperTransaction.read(id);
    daftarUtang = [];
    for (var element in utang) {
      daftarUtang!.add(TransactionModel.fromJson(element));
    }
    return daftarUtang!;
  }

  ///prosedur membaca daftar utang pada pelanggan yang dipilih.
  Future<void> readDebt(int id) async {
    daftarUtang = await getAllDebt(id);
    notifyListeners();
  }

  ///prosedur menghapus utang apabila tersisa 1 utang pada pelanggan yang dipilih.
  Future<void> deleteCustomerIfNoDebtAnymore(int id) async {
    await _supabaseHelperTransaction.deleteCustomerAndTransaction(id);
    notifyListeners();
  }

  ///prosedur menghapus 1 utang pada pelanggan yang dipilih.
  Future<void> deleteDebt(int id) async {
    await _supabaseHelperTransaction.deleteTransaction(id);
    notifyListeners();
  }

  ///prosedur menghitung total utang per pelanggan.
  Future<void> debtSum(int id) async {
    totalUtang = await _supabaseHelperTransaction.sum(id);
    notifyListeners();
  }
}
