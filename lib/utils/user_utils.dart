import 'package:sp_util/sp_util.dart';
import 'package:tencent_cloud_chat_demo/model/user_model.dart';

class UserUtils {
  static UserModel? userModel;

  static saveUserModel(UserModel userModel) async {
    UserUtils.userModel = userModel;
    SpUtil.putObject('userModel', userModel);
  }

  static UserModel? getUserModel() {
    return SpUtil.getObj('userModel', (v) => UserModel.fromJson(v));
  }
}
