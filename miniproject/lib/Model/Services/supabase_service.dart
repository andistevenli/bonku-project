import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  initSupabase() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Supabase.initialize(
      url: 'https://imwhkmswfkxlfmdbhyhr.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imltd2hrbXN3Zmt4bGZtZGJoeWhyIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4Mjc1MTM0MSwiZXhwIjoxOTk4MzI3MzQxfQ.5vbT2A22LAAZ6xWww_u2EjJflZVLCfnRXwN5td0oJHg',
    );
  }
}
