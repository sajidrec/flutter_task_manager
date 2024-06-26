import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class EmailVerificationController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> emailVerification(String email) async {
    bool isSuccessful = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(
      Urls.forgetPasswordEmailUrl(
        email.trim(),
      ),
    );

    if (response.isSuccess) {
      isSuccessful = true;

    } else {
      _errorMessage = "Something Went Wrong.";
    }

    _inProgress = false;
    update();
    return isSuccessful;
  }
}
