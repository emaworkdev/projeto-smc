import 'package:server_smc/core/helpers/cripty_helper.dart';
import 'package:server_smc/models/user_model.dart';
import 'package:server_smc/services/user_hasura_service.dart';

class UserRepository {
  var hasuraUser = UserHasuraService();
  Future<UserModel> login(String email, String password) async {
    UserModel user = UserModel();
    try {
      var reth = await hasuraUser.existe(email);
      if (reth) {
        user = await hasuraUser.login(email, password);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    return user;
  }

  Future<String> save(UserModel obj) async {
    var ret = '0';
    try {
      var reth = await hasuraUser.existe(obj.email!);
      if (reth) {
        ret = await hasuraUser.update(obj);
      } else {
        ret = await hasuraUser.create(obj);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    return ret;
  }

  delete(int id) async {
    try {
      await hasuraUser.delete(id);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  register(UserModel obj) async {
    try {
      await hasuraUser.create(obj);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<bool> updatePassword(String email, String password) async {
    var ret = false;
    try {
      var pass = CriptyHelper.generatedSha256Hash(password);
      var rt = await hasuraUser.updatePassword(email, pass);
      if (rt != '0') {
        ret = true;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    return ret;
  }
}
