import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

@override
class RiverPodUserType extends AsyncNotifier<String?> {
  @override
  FutureOr<String?> build() {
    return getUserType();
  }

  FutureOr<String?> getUserType() {
    return state.value;
  }

  FutureOr<void> setUserType(String userType) {
    state = AsyncValue.data(userType);
  }

}