import 'package:clean_arch2/config/db/hiver_riverpod/riverpod_db.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/admin/model/admin.model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../auth/model/signup/signup.model.dart';
import '../pod-entry/pod_entry.dart';

@riverpod

class AdminAuthRiverPod extends AsyncNotifier<AdminCredentials?>{

  @override
  FutureOr<AdminCredentials?> build() {
    return null;
  }

  FutureOr<int?> singupAdmin(SupaUserModel user) async {
    final adminAuth = await ref.read(riverpodDbProvider.notifier).supaAdminSignup(user);

    return adminAuth;
  }
  
  FutureOr<void> signinAdmin(SupaLoginUser user) async {
    final adminAuth = await ref.read(adminAuthPod.notifier).signinAdmin(user);
    
  }
  
}
