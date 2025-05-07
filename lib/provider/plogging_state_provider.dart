import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'plogging_state_provider.g.dart';

class PloggingState {
  final bool isActive;

  const PloggingState({required this.isActive});

  PloggingState copyWith({bool? isActive}) {
    return PloggingState(
      isActive: isActive ?? this.isActive,
    );
  }
}

@riverpod
class PloggingStateNotifier extends _$PloggingStateNotifier {
  @override
  PloggingState build() {
    return const PloggingState(isActive: false);
  }

  void togglePloggingState() {
    state = state.copyWith(isActive: !state.isActive);
  }

  void setPloggingState(bool isActive) {
    state = state.copyWith(isActive: isActive);
  }

  void reset() {
    state = const PloggingState(isActive: false);
  }
}
