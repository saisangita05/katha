import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseClientSetup {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://acsrqbxziftlcohqvztj.supabase.co', // Replace with your Supabase URL
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFjc3JxYnh6aWZ0bGNvaHF2enRqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkyNzk0NzUsImV4cCI6MjA1NDg1NTQ3NX0.ZuE7zrwTNE8AHQZ5J6fLpGy3pj_jEigkhsWj-41dQpM', // Replace with your Supabase Anon Key
    );
  }
}
