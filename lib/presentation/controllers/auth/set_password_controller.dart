import 'package:get/get.dart';
import 'package:task_manager/data/models/set_password_object.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class SetPasswordController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> setPassword(SetPasswordObject setPasswordObject) async {
    bool isSuccessful = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller.postRequest(
      Urls.setPasswordUrl,
      setPasswordObject.toJson(),
    );

    if (response.isSuccess) {
      isSuccessful = true;
    } else {
      _errorMessage = "Something went wrong.";
    }

    _inProgress = false;
    update();
    return isSuccessful;
  }
}
