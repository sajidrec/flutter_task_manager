import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class EmailVerificationController extends GetxController {
  bool _inprogress = false;
  String _errorMessage = "";

  bool get inProgress => _inprogress;

  String get errorMessage => _errorMessage;

  Future<bool> emailVerification(String email) async {
    bool isSuccessful = false;
    _inprogress = true;
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

    _inprogress = false;
    update();
    return isSuccessful;
  }
}
