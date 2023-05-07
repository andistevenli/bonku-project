import 'package:flutter/material.dart';
import 'package:miniproject/Model/Services/supabase_service.dart';

import 'my_app.dart';

void main() async {
  final SupabaseService supabaseService = SupabaseService();
  await supabaseService.initSupabase();
  runApp(const MyApp());
}
