import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:task_manager/data/models/response_object.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = "";

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> signUp({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
  }) async {
    _inProgress = true;
    update();
    bool isSuccessful = false;

    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": "",
    };

    final dummyImage = await get(
      Uri.parse(
        "https://i.ibb.co/7vj91CB/ok.png",
      ),
    );

    inputParams["photo"] = base64Encode(dummyImage.bodyBytes);

    final ResponseObject response =
        await NetworkCaller.postRequest(Urls.registration, inputParams);

    if (response.isSuccess) {
      isSuccessful = true;
    } else {
      _errorMessage = response.errorMessage ?? "Signup failed";
    }

    _inProgress = false;
    update();
    return isSuccessful;
  }
}
