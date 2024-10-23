import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

export 'database/database.dart';

String _kSupabaseUrl = 'https://ropnkxbwuoazkzvwrfzi.supabase.co';
String _kSupabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJvcG5reGJ3dW9hemt6dndyZnppIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjkyNzI1NjEsImV4cCI6MjA0NDg0ODU2MX0.idfdAHpJuIS-jGiAnZ0JhALzve71eFMzrvtu4M4-v2I';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;
  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;
  static SupabaseClient get client => instance._supabase;

  static Future initialize() => Supabase.initialize(
        url: _kSupabaseUrl,
        anonKey: _kSupabaseAnonKey,
        debug: false,
      );
}
