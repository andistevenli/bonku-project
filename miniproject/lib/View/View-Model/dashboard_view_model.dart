import 'package:flutter/material.dart';
import 'package:miniproject/Model/helper/supabase_helper_dashboard.dart';

class DashboardViewModel with ChangeNotifier {
  int? totalUtang;
  int? totalPelanggan;

  final SupabaseHelperDashboard _supabaseHelperDashboard =
      SupabaseHelperDashboard();

  Future<void> debtSum() async {
    totalUtang = await _supabaseHelperDashboard.readDebtSum();
    notifyListeners();
  }

  Future<void> customerSum() async {
    totalPelanggan = await _supabaseHelperDashboard.readCustomerSum();
    notifyListeners();
  }
}
