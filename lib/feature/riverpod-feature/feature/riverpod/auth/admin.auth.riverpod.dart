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

  FutureOr<void> singupAdmin(SupaUserModel user) {
    final adminAuth = ref.read(adminAuthPod.notifier).singupAdmin(user);
    
  }
  
  FutureOr<void> signinAdmin(SupaLoginUser user) async {
    final adminAuth = await ref.read(adminAuthPod.notifier).signinAdmin(user);
    
  }
  
}
