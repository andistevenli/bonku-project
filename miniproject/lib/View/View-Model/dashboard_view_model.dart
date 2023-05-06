import 'package:flutter/material.dart';
import 'package:miniproject/Model/helper/supabase_helper_dashboard.dart';

class DashboardViewModel with ChangeNotifier {
  int? totalUtang;
  int? totalPelanggan;

  final SupabaseHelperDashboard _supabaseHelperDashboard =
      SupabaseHelperDashboard();

  //prosedur menghitung total utang keseluruhan.
  Future<void> debtSum() async {
    totalUtang = await _supabaseHelperDashboard.readDebtSum();
    notifyListeners();
  }

  ///prosedur menghitung total pelanggan keseluruhan.
  Future<void> customerSum() async {
    totalPelanggan = await _supabaseHelperDashboard.readCustomerSum();
    notifyListeners();
  }
}
