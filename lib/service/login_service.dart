import '../helpers/user.info.dart';

class LoginService {
  Future<bool> login(String username, String password) async {
    bool isLogin = false;
    if (username == 'july' && password == 'lezatos') {
      await UserInfo().setToken("july");
      await UserInfo().setUserID("1");
      await UserInfo().setUsername("july");
      isLogin = true;
    }
    return isLogin;
  }
}
