import 'package:ploop_fe/model/user_info_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_info_provider.g.dart';

@Riverpod(keepAlive: true)
class UserInfoNotifier extends _$UserInfoNotifier {
  UserInfoNotifier() : super();

  @override
  UserInfoUi build() {
    return UserInfoUi(id: -1, nickname: '', pictureUrl: '');
  }

  void setId(int id) {
    state = state.copyWith(id: id);
  }

  void setNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  void setPictureUrl(String url) {
    state = state.copyWith(pictureUrl: url);
  }

  void reset() {
    state = UserInfoUi(id: -1, nickname: '', pictureUrl: '');
  }
}
