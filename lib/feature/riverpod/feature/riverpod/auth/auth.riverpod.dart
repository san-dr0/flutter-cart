import 'dart:async';

import 'package:clean_arch2/feature/riverpod/model/auth/auth.riverpod.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRiverPod extends AsyncNotifier<AuthRiverPodModel?> {
  
  @override
  FutureOr<AuthRiverPodModel?> build() {
    return null;
  }
  
  AsyncValue<AuthRiverPodModel?> getActiveUser() {
    return state;
  }
}
