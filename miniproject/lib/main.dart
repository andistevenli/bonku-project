import 'package:flutter/material.dart';
import 'package:miniproject/Model/Services/supabase_service.dart';

import 'my_app.dart';

void main() {
  final SupabaseService supabaseService = SupabaseService();

  supabaseService.initSupabase();

  runApp(const MyApp());
}
