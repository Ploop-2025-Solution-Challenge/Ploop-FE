import 'package:ploop_fe/model/jwt.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'jwt_provider.g.dart';

@Riverpod(keepAlive: true)
class JwtNotifier extends _$JwtNotifier {
  JwtNotifier() : super();

  @override
  AuthToken build() {
    return AuthToken(jwt: null);
  }

  void setToken() async {
    final prefs = await SharedPreferences.getInstance();
    state = state.copyWith(jwt: prefs.getString('jwt'));
  }

  void reset() {
    state = AuthToken(jwt: null);
  }
}
