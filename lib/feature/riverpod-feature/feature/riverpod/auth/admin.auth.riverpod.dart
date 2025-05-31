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
  
  FutureOr<SupaUserModelRetrieve?> signinAdmin(SupaLoginUser user) async {
    final adminAuth = await ref.read(riverpodDbProvider.notifier).supaAdminLogin(user);
    if (adminAuth != null) {
      AdminCredentials adminCredentials = AdminCredentials(
        id: adminAuth.id, 
        firstName: adminAuth.firstname, 
        lastName: adminAuth.lastname, 
        middleName: 'No md', 
        email: adminAuth.email, 
        password: adminAuth.password
      );

      state = AsyncValue.data(adminCredentials);

      return adminAuth;
    }
    
    return null;
  }
  
}
