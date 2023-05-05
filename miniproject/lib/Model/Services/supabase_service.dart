import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  initSupabase() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Supabase.initialize(
      url: 'https://vzrlymtevysbompwvsbk.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ6cmx5bXRldnlzYm9tcHd2c2JrIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4MzE3Nzg5OSwiZXhwIjoxOTk4NzUzODk5fQ.CtmMfR5G_8X_VFhyY3XSCSOjqSc9Num88M6hKjL8-d4',
    );
  }
}
