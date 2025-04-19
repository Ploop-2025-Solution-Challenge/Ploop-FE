// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ploop_fe/model/user_request.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// @riverpod
// class UserPreferenceNotifier extends _$StateNotifier {
//   UserPreferenceNotifier() : super(const UserRequest());

//   void setCountry(String country) {
//     state = state.copyWith(country: country);
//   }

//   void setRegion(String region) {
//     state = state.copyWith(region: region);
//   }

//   void setBirthDate(DateTime birthDate) {
//     state = state.copyWith(birthDate: birthDate);
//   }

//   void setGender(String gender) {
//     state = state.copyWith(gender: gender);
//   }

//   void setNickname(String nickname) {
//     state = state.copyWith(nickname: nickname);
//   }

//   void setDifficulty(String level) {
//     state = state.copyWith(ploggingLevel: level);
//   }

//   void setMotivation(List<String> motivations) {
//     state = state.copyWith(motivations: motivations);
//   }

//   void setPreferredAreas(List<String> areas) {
//     if (areas.length <= 3) {
//       state = state.copyWith(preferredAreas: areas);
//     }
//   }

//   void reset() {
//     state = const UserRequest();
//   }
// }
