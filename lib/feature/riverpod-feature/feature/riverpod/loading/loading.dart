import 'package:riverpod_annotation/riverpod_annotation.dart';

@riverpod
class LoadingPod extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    return true;
  }

  FutureOr<bool> getLoadingStatus () {
    return state.isLoading;
  }

  FutureOr<void> setLoadingStatus() {
    state = AsyncValue.data(false);
  }
}
