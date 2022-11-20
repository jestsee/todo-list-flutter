import 'package:hooks_riverpod/hooks_riverpod.dart' as r;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final supabaseClientProvider = r.Provider<SupabaseClient>((_) => SupabaseClient(
    dotenv.env['SUPABASE_URL']!, dotenv.env['SUPABASE_SECRET']!));
