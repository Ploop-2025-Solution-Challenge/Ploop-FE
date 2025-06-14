import 'package:ploop_fe/model/user_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_prefs_provider.g.dart';

@Riverpod(keepAlive: true)
class UserPreferenceNotifier extends _$UserPreferenceNotifier {
  UserPreferenceNotifier() : super();

  @override
  UserRequest build() {
    return const UserRequest(
      nickname: '',
      age: 0,
      gender: '',
      country: '',
      difficulty: '',
      motivation: '',
      preferredArea: [],
    );
  }

  void setCountry(String country) {
    state = state.copyWith(country: country);
  }

  void setAge(int age) {
    state = state.copyWith(age: age);
  }

  void setGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void setNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  void setDifficulty(String level) {
    state = state.copyWith(difficulty: level);
  }

  void setMotivation(String motivation) {
    state = state.copyWith(motivation: motivation);
  }

  void setPreferredAreas(List<String> areas) {
    if (areas.length <= 3) {
      state = state.copyWith(preferredArea: areas);
    }
  }

  void reset() {
    state = const UserRequest(
        nickname: '',
        age: 0,
        gender: '',
        country: '',
        difficulty: '',
        motivation: '',
        preferredArea: []);
  }
}
