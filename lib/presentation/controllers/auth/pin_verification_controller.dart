import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class PinVerificationController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> pinVerification(String email, String pinCode) async {
    bool isSuccessful = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(
      Urls.verifyOtpUrl(email, pinCode),
    );

    print("Eta custom message ${email} - ${pinCode}");

    print(response.responseBody);

    if (response.responseBody["status"] == "success") {
      isSuccessful = true;
    } else {
      _errorMessage = "Wrong Pin Code";
    }

    _inProgress = false;
    update();
    return isSuccessful;
  }
}
