import 'package:hooks_riverpod/hooks_riverpod.dart' as r;
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:todo_list/controllers/auth_controller.dart';
import 'package:todo_list/model/user_state.dart';
import 'package:todo_list/repositories/auth/auth_repository.dart';

// supabase
final supabaseClientProvider = r.Provider<SupabaseClient>(
    ((_) => Supabase.instance.client));

// authentication
final authRepositoryProvider =
    r.Provider<AuthRepository>((ref) => AuthRepository(ref));

final authStateChangesProvider = r.StreamProvider<AuthState>(
    ((ref) => ref.watch(authRepositoryProvider).authStateChanges));

final authControllerProvider =
    r.StateNotifierProvider<AuthController, UserState>(
        (ref) => AuthController(ref)..appStarted());
