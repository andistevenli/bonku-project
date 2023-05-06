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

  Future<void> createDebt(int idPelanggan, String deskripsi, int utang) async {
    await _supabaseHelperTransaction.create(idPelanggan, deskripsi, utang);
    notifyListeners();
  }

  ///mengembalikan data yang ada pada tabel 'transaksi' berdasarkan id pada tabel 'pelanggan'.
  Future<List<TransactionModel>> getAllDebt(int id) async {
    utang = await _supabaseHelperTransaction.read(id);
    daftarUtang = [];
    for (var element in utang) {
      daftarUtang!.add(TransactionModel.fromJson(element));
    }
    return daftarUtang!;
  }

  Future<void> readDebt(int id) async {
    daftarUtang = await getAllDebt(id);
    notifyListeners();
  }

  Future<void> deleteCustomerIfNoDebtAnymore(int id) async {
    await _supabaseHelperTransaction.deleteCustomerAndTransaction(id);
    notifyListeners();
  }

  Future<void> deleteDebt(int id) async {
    await _supabaseHelperTransaction.deleteTransaction(id);
    notifyListeners();
  }

  Future<void> debtSum(int id) async {
    totalUtang = await _supabaseHelperTransaction.sum(id);
    notifyListeners();
  }
}
